From: Oliver Henriot <Oliver.Henriot@imag.fr>
Subject: Re: Power States
Date: Thu, 21 Dec 2006 08:33:52 +0100
Message-ID: <458A38E0.40108@imag.fr>
References: <569c97d20612201033g69b7d345i657dc6f62f591854@mail.gmail.com>	 <45898257.5060004@linux.intel.com>	 <569c97d20612201051la543b85r11a789affe356e1@mail.gmail.com>	 <458988A4.7050801@linux.intel.com> <569c97d20612201109i7c8d3accl6ac2346ba023401b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms010607060207010206040904"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imag.imag.fr ([129.88.30.1]:32875 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422806AbWLUHeP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Dec 2006 02:34:15 -0500
Received: from [129.88.28.55] (jahnu.imag.fr [129.88.28.55])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id kBL7Xq95024957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2006 08:33:52 +0100 (CET)
In-Reply-To: <569c97d20612201109i7c8d3accl6ac2346ba023401b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010607060207010206040904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Dans sa grande sagesse, Balaji Rao a écrit, le 20.12.2006 20:09 :
> also, the file cat /proc/acpi/processor/CPU1/info gives this
>
> processor id:            0
> acpi id:                 1
> bus mastering control:   yes
> power management:        no
> throttling control:      yes
> limit interface:         yes
Indeed, that's odd. I've got yes for pm on mine...
>
> One more thing is that, only two frequency levels ( 1.86 and 1.6 Ghz)
> are being used. This does not cause much power saving..
>
> How many levels are actually available on core 2 duo?
cpufreq stages from 1GHz to 2GHz via 4 steps (1.33 and 1.67 
intermediate) on my T7200, can't say for your E6300.
>
> I cant find any PSS in the DSDT dump.
Neither can I but that doesn't seem to be a problem ;-)
Can't help you more with DSDT, you probably know more about it than I 
do, I've got a lot of rtfming to do yet...

Cheers,

--------------ms010607060207010206040904
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIMzzCC
A20wggJVoAMCAQICAQIwDQYJKoZIhvcNAQEEBQAwKzELMAkGA1UEBhMCRlIxDTALBgNVBAoT
BENOUlMxDTALBgNVBAMTBENOUlMwHhcNMDEwNDI3MDU0NjQ5WhcNMTEwNDI1MDU0NjQ5WjA0
MQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05SUzEWMBQGA1UEAxMNQ05SUy1TdGFuZGFyZDCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANzhHiE9BovqvV60iNsPk5e0bQc9hmIA
Lcr/tUqO51akj2Es8aAqq/Yq3Xwsv+91VQusCU7nTmHA5wzwkBVFEgLCjOvDEmTiYxAYLssH
MdmB5dwpgpsxVuKBHopvp+ipWBFEVoNds054cC3ftv1ygUXV8e5Nzu++1T0MkCBFmgmArw9M
2iAOgL86s+sngMC5D8ChTkDcOv1qKr9A1SxxgPn4umvk6ioAqy++mvCndm2YKZwPL/BC8hiX
W8n2zBlfusK+EtJcsJCUwLfLBgTvjzDtMi16SveTu6AJpLTuM8vQg5u1tbOQ3o6QHlmcINVL
Hu3XTE+G+hw6KqHprAWgnb8CAwEAAaOBkjCBjzAMBgNVHRMEBTADAQH/MB0GA1UdDgQWBBRn
WaXlB3RJA+8Fz8wupBjVEMiePDBTBgNVHSMETDBKgBRW62i50lx+mLWlU8ORb2NYxPlrt6Ev
pC0wKzELMAkGA1UEBhMCRlIxDTALBgNVBAoTBENOUlMxDTALBgNVBAMTBENOUlOCAQAwCwYD
VR0PBAQDAgEGMA0GCSqGSIb3DQEBBAUAA4IBAQAGA0eDckWQwk7hIderF6kBVQbKQG1Voh1e
6+IUI1nkCeKQ9jyNNgYPS6cmI2XC6gaacru4jMuKX+95NiV+ANfzBpT7g0QpJjfH7umHzmyG
gBtxPdJir/bNYmxTD+Z6kwCMey4z4EEdqr5lmHbxlQd0s+Y/U3XVSwY2SynE9tyOE4BAEHOC
rRV7BHFQtTcz8shku6EQfjbGra9vcFKm0a7MzLqw6FkSj2INrQPdSyroiTmIUS/tYei3MIfb
J1VtZoejUQmAYXFRBb4THdlBMPx1XwqWmxj/vpCBtBPAchEI/Wqaage99IMstGA2ZAf6PWqn
sJAEdoPdM8s04heYBAuhMIIEqzCCA5OgAwIBAgICPqowDQYJKoZIhvcNAQEEBQAwNDELMAkG
A1UEBhMCRlIxDTALBgNVBAoTBENOUlMxFjAUBgNVBAMTDUNOUlMtU3RhbmRhcmQwHhcNMDYw
OTA0MTE0MDQyWhcNMDcwOTA0MTE0MDQyWjBrMQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05S
UzENMAsGA1UECxMERlI3MTEXMBUGA1UEAxMOT2xpdmVyIEhlbnJpb3QxJTAjBgkqhkiG9w0B
CQEWFk9saXZlci5IZW5yaW90QGltYWcuZnIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQCyNl4NNKoxifg7S153OeCW5a54sL+5LiDJnYJxkpJAXIkvg3dCCFEah7Ui47aIhWwI
lixnwZQKrm2rf6bz7hR1XF6snAMXJdqN6tDA+j3Spno/Ap77wZjJvYV4m9vM0JTF5rzcO0am
Mb0XP2rSw89bbI7+IXNl90/toJT+BkplGsxJi561C0HgbCxvmLG+q75UW78pv+d41lQbs96M
bjHUQGyDkzt1AtU3OW1YiHr33BIyNXSYSfHGgfz3ZOjb496bfCTftLs9xro5HkpYI5PNOa1x
Or6R9uOydv+KX010kjTb5H+WZCGo2mzHaO4i7taKbCUKt7V09d2zX8XQH+NbAgMBAAGjggGO
MIIBijAMBgNVHRMBAf8EAjAAMBEGCWCGSAGG+EIBAQQEAwIEsDAOBgNVHQ8BAf8EBAMCBeAw
eAYJYIZIAYb4QgENBGsWaUNlcnRpZmljYXQgQ05SUy1TdGFuZGFyZC4gUG91ciB0b3V0ZSBp
bmZvcm1hdGlvbiBzZSByZXBvcnRlciDgIGh0dHA6Ly9pZ2Muc2VydmljZXMuY25ycy5mci9D
TlJTLVN0YW5kYXJkLzAdBgNVHQ4EFgQU6H78Ol0mMubat4BoYbZ/Rw/j/l0wUwYDVR0jBEww
SoAUZ1ml5Qd0SQPvBc/MLqQY1RDInjyhL6QtMCsxCzAJBgNVBAYTAkZSMQ0wCwYDVQQKEwRD
TlJTMQ0wCwYDVQQDEwRDTlJTggECMCEGA1UdEQQaMBiBFk9saXZlci5IZW5yaW90QGltYWcu
ZnIwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybHMuc2VydmljZXMuY25ycy5mci9DTlJT
LVN0YW5kYXJkL2dldGRlci5jcmwwDQYJKoZIhvcNAQEEBQADggEBAB8tLxj4B1fWbQDswyyR
FtHYSkomAFb5ajZVvlRQL9AGGzWvLj7Skn286EOStNGtekmJJ+tZsFlWgNeV3b06XmPa4D8X
znTTlQjSl5eMHJ7n07xips8br+uhUZRlAGN49fKV4aSTY3D+/2u45X6lFLZP7bM1MmtqXgcD
u6XWZQupvOUfa9w8+hozfsIWlzhIcfXmFXa7+R7kXjk/39RDk0/9pN8v5Xp67PBSKp44CR1D
HwBfEoFLHkErr/3yjIK42uiiTerxmfnARGQB2VXHd6ENf+TbtZRoTNcADndi/WbW3TaCWO9D
AQJtxj0k7xJwN/+WkRalbUu+GoF9+ZKyVFIwggSrMIIDk6ADAgECAgI+qjANBgkqhkiG9w0B
AQQFADA0MQswCQYDVQQGEwJGUjENMAsGA1UEChMEQ05SUzEWMBQGA1UEAxMNQ05SUy1TdGFu
ZGFyZDAeFw0wNjA5MDQxMTQwNDJaFw0wNzA5MDQxMTQwNDJaMGsxCzAJBgNVBAYTAkZSMQ0w
CwYDVQQKEwRDTlJTMQ0wCwYDVQQLEwRGUjcxMRcwFQYDVQQDEw5PbGl2ZXIgSGVucmlvdDEl
MCMGCSqGSIb3DQEJARYWT2xpdmVyLkhlbnJpb3RAaW1hZy5mcjCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBALI2Xg00qjGJ+DtLXnc54Jblrniwv7kuIMmdgnGSkkBciS+Dd0II
URqHtSLjtoiFbAiWLGfBlAqubat/pvPuFHVcXqycAxcl2o3q0MD6PdKmej8CnvvBmMm9hXib
28zQlMXmvNw7RqYxvRc/atLDz1tsjv4hc2X3T+2glP4GSmUazEmLnrULQeBsLG+Ysb6rvlRb
vym/53jWVBuz3oxuMdRAbIOTO3UC1Tc5bViIevfcEjI1dJhJ8caB/Pdk6Nvj3pt8JN+0uz3G
ujkeSlgjk805rXE6vpH247J2/4pfTXSSNNvkf5ZkIajabMdo7iLu1opsJQq3tXT13bNfxdAf
41sCAwEAAaOCAY4wggGKMAwGA1UdEwEB/wQCMAAwEQYJYIZIAYb4QgEBBAQDAgSwMA4GA1Ud
DwEB/wQEAwIF4DB4BglghkgBhvhCAQ0EaxZpQ2VydGlmaWNhdCBDTlJTLVN0YW5kYXJkLiBQ
b3VyIHRvdXRlIGluZm9ybWF0aW9uIHNlIHJlcG9ydGVyIOAgaHR0cDovL2lnYy5zZXJ2aWNl
cy5jbnJzLmZyL0NOUlMtU3RhbmRhcmQvMB0GA1UdDgQWBBTofvw6XSYy5tq3gGhhtn9HD+P+
XTBTBgNVHSMETDBKgBRnWaXlB3RJA+8Fz8wupBjVEMiePKEvpC0wKzELMAkGA1UEBhMCRlIx
DTALBgNVBAoTBENOUlMxDTALBgNVBAMTBENOUlOCAQIwIQYDVR0RBBowGIEWT2xpdmVyLkhl
bnJpb3RAaW1hZy5mcjBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vY3Jscy5zZXJ2aWNlcy5j
bnJzLmZyL0NOUlMtU3RhbmRhcmQvZ2V0ZGVyLmNybDANBgkqhkiG9w0BAQQFAAOCAQEAHy0v
GPgHV9ZtAOzDLJEW0dhKSiYAVvlqNlW+VFAv0AYbNa8uPtKSfbzoQ5K00a16SYkn61mwWVaA
15XdvTpeY9rgPxfOdNOVCNKXl4wcnufTvGKmzxuv66FRlGUAY3j18pXhpJNjcP7/a7jlfqUU
tk/tszUya2peBwO7pdZlC6m85R9r3Dz6GjN+whaXOEhx9eYVdrv5HuReOT/f1EOTT/2k3y/l
enrs8FIqnjgJHUMfAF8SgUseQSuv/fKMgrja6KJN6vGZ+cBEZAHZVcd3oQ1/5Nu1lGhM1wAO
d2L9ZtbdNoJY70MBAm3GPSTvEnA3/5aRFqVtS74agX35krJUUjGCAq4wggKqAgEBMDowNDEL
MAkGA1UEBhMCRlIxDTALBgNVBAoTBENOUlMxFjAUBgNVBAMTDUNOUlMtU3RhbmRhcmQCAj6q
MAkGBSsOAwIaBQCgggFJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkF
MQ8XDTA2MTIyMTA3MzM1MlowIwYJKoZIhvcNAQkEMRYEFMjyNtH/GZfe9ljmNrh9dzT73vgh
MEkGCSsGAQQBgjcQBDE8MDowNDELMAkGA1UEBhMCRlIxDTALBgNVBAoTBENOUlMxFjAUBgNV
BAMTDUNOUlMtU3RhbmRhcmQCAj6qMEsGCyqGSIb3DQEJEAILMTygOjA0MQswCQYDVQQGEwJG
UjENMAsGA1UEChMEQ05SUzEWMBQGA1UEAxMNQ05SUy1TdGFuZGFyZAICPqowUgYJKoZIhvcN
AQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEggEAVLpfUVJH+4/2Df/kUWdV
rJtVQwHrAgNhx2sBisyb/mbz94d1UAEpzF+yL8xu8kxU7yU0xEixP89URMRsnxgtS/z6OheL
dflOI4VoRE8tYEcxVTYOmxLEWHlyFxBf3nZjH5NQxyhNsiRWrjTM9PaoCiSkMPPhavxfCgYD
uE5ko4y0IyzUMXSE2bp993YdT3csbzyEzQIbFfrmbMMuY3t0JMlim3Qz75eR/3sh31D25rm1
QFaYYyHGE2VCNJ8NgqtZMOaX29H4ilwJc2l5Uz/avRNvfGOMyQfifA9dhmiHlrPTnoFhpj3w
bHHQdxapb2tatPoqsGoCaGfN6+HF7nyg6wAAAAAAAA==
--------------ms010607060207010206040904--
