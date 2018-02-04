---
layout: default
title: Server Certificates
permalink: /certificates/
---

# Server Certificates
One of the benefits of communicating via XMPP is the level of security involved.  To allow users to validate the servers they are connecting to, below is the current fingerprints for each domain name.

<div id="cert-table">
<h2>{{ site.xmpp-url }}</h2>
<p style="margin-top:-0.6em;"><small>(expires: {{ site.fingerprint-expires }})</small></p>
{% if site.fingerprint-sha1 %}
  <div class="cert-title">
    <b>SHA1 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-sha1 }}</pre>
  </div>
{% endif %}
{% if site.fingerprint-sha256 %}
  <div class="cert-title">
    <b>SHA256 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-sha256 }}</pre>
  </div>
{% endif %}
{% if site.xmpp-host %}
<h2>{{ site.xmpp-host }}</h2>
<p style="margin-top:-0.6em;"><small>(expires: {{ site.fingerprint-im-expires }})</small></p>
{% if site.xmpp-host and site.fingerprint-im-sha1 %}
  <div class="cert-title">
    <b>SHA1 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-im-sha1 }}</pre>
  </div>
{% endif %}
{% if site.xmpp-host and site.fingerprint-im-sha256 %}
  <div class="cert-title">
    <b>SHA256 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-im-sha256 }}</pre>
  </div>
{% endif %}
{% endif %}
{% if site.xmpp-conference-url and site.xep-0045 == 1 %}
<h2>{{ site.xmpp-conference-url }}</h2>
<p style="margin-top:-0.6em;"><small>(expires: {{ site.fingerprint-conference-expires }})</small></p>
{% if site.xmpp-conference-url and site.xep-0045 == 1 and site.fingerprint-conference-sha1 %}
  <div class="cert-title">
    <b>SHA1 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-conference-sha1 }}</pre>
  </div>
{% endif %}
{% if site.xmpp-conference-url and site.xep-0045 == 1 and site.fingerprint-conference-sha256 %}
  <div class="cert-title">
    <b>SHA256 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-conference-sha256 }}</pre>
  </div>
{% endif %}
{% endif %}
{% if site.xmpp-proxy-url and site.xep-0065 == 1 %}
<h2>{{ site.xmpp-proxy-url }}</h2>
<p style="margin-top:-0.6em;"><small>(expires: {{ site.fingerprint-proxy-expires }})</small></p>
{% if site.xmpp-proxy-url and site.xep-0065 == 1 and site.fingerprint-proxy-sha1 %}
  <div class="cert-title">
    <b>SHA1 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-proxy-sha1 }}</pre>
  </div>
{% endif %}
{% if site.xmpp-proxy-url and site.xep-0065 == 1 and site.fingerprint-proxy-sha256 %}
  <div class="cert-title">
    <b>SHA256 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-proxy-sha256 }}</pre>
  </div>
{% endif %}
{% endif %}
{% if site.xmpp-upload-url and site.xep-0363 == 1 %}
<h2>{{ site.xmpp-upload-url }}</h2>
<p style="margin-top:-0.6em;"><small>(expires: {{ site.fingerprint-upload-expires }})</small></p>
{% if site.xmpp-upload-url and site.xep-0363 == 1 and site.fingerprint-upload-sha1 %}
  <div class="cert-title">
    <b>SHA1 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-upload-sha1 }}</pre>
  </div>
{% endif %}
{% if site.xmpp-upload-url and site.xep-0363 == 1 and site.fingerprint-upload-sha256 %}
  <div class="cert-title">
    <b>SHA256 Fingerprint</b>
  </div>
  <div class="cert-content">
    <pre>{{ site.fingerprint-upload-sha256 }}</pre>
  </div>
{% endif %}
{% endif %}
</div> <!-- Closing cert-table id div -->

<p style='text-align:right;'><a href="https://check.messaging.one/result.php?domain={{ site.xmpp-url }}&amp;type=server"><img src="https://check.messaging.one/badge.php?domain={{ site.xmpp-url }}" alt="check.messaging.one server score" /></a></p>

