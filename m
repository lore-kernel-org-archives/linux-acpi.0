From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: standby problem
Date: Mon, 19 Sep 2005 17:00:25 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F171FA38@pdsmsx406>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5BCF8.93D7D823"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5BCF8.93D7D823
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
>
>> >> i wanted to know what's mean this error :)
>> >>
>> >> mrspurr:/home/giskard# echo standby > /sys/power/state
>> >> acpi_pm_prepare does not support 1
>> >>
>> >> means that my laptop doesn't supporto standby mode?
>> >
>> >Probably yes.
>> Is it possible we can just show available pm states in
/sys/power/state?
>> I think we should report the error earlier before we do actual
>> suspend/resume. (maybe pm_ops should have a .supported_states
callback
>> for all archs) It seems many users are complaining about this after
Len
>> deprecated the proc interface.
>
>Pavel Troller even had a patch, but it was too ugly. Yes, we should
>only list available states in /sys/power/state.
Ok, how does this one look? Each arch provides a .valid callback.

Thanks,
Shaohua

------_=_NextPart_001_01C5BCF8.93D7D823
Content-Type: application/octet-stream;
	name="pm_states_cleanup.patch"
Content-Transfer-Encoding: base64
Content-Description: pm_states_cleanup.patch
Content-Disposition: attachment;
	filename="pm_states_cleanup.patch"

CgotLS0KCiBsaW51eC0yLjYuMTQtcmMxLXJvb3QvZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYyB8
ICAgIDggKysrKysrKysKIGxpbnV4LTIuNi4xNC1yYzEtcm9vdC9pbmNsdWRlL2xpbnV4L3BtLmgg
ICAgICAgIHwgICAgMSArCiBsaW51eC0yLjYuMTQtcmMxLXJvb3Qva2VybmVsL3Bvd2VyL21haW4u
YyAgICAgICB8ICAgIDUgKysrKy0KIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtcHVOIGtlcm5lbC9wb3dlci9tYWluLmN+cG1fc3RhdGVzX2Ns
ZWFudXAga2VybmVsL3Bvd2VyL21haW4uYwotLS0gbGludXgtMi42LjE0LXJjMS9rZXJuZWwvcG93
ZXIvbWFpbi5jfnBtX3N0YXRlc19jbGVhbnVwCTIwMDUtMDktMTkgMTY6MzI6NTMuMDAwMDAwMDAw
ICswODAwCisrKyBsaW51eC0yLjYuMTQtcmMxLXJvb3Qva2VybmVsL3Bvd2VyL21haW4uYwkyMDA1
LTA5LTE5IDE2OjUxOjEyLjAwMDAwMDAwMCArMDgwMApAQCAtMTY3LDYgKzE2Nyw4IEBAIHN0YXRp
YyBpbnQgZW50ZXJfc3RhdGUoc3VzcGVuZF9zdGF0ZV90IHMKIHsKIAlpbnQgZXJyb3I7CiAKKwlp
ZiAocG1fb3BzLT52YWxpZCAmJiAhcG1fb3BzLT52YWxpZChzdGF0ZSkpCisJCXJldHVybiAtRU5P
REVWOwogCWlmIChkb3duX3RyeWxvY2soJnBtX3NlbSkpCiAJCXJldHVybiAtRUJVU1k7CiAKQEAg
LTIzNiw3ICsyMzgsOCBAQCBzdGF0aWMgc3NpemVfdCBzdGF0ZV9zaG93KHN0cnVjdCBzdWJzeXN0
CiAJY2hhciAqIHMgPSBidWY7CiAKIAlmb3IgKGkgPSAwOyBpIDwgUE1fU1VTUEVORF9NQVg7IGkr
KykgewotCQlpZiAocG1fc3RhdGVzW2ldKQorCQlpZiAocG1fc3RhdGVzW2ldICYmIHBtX29wcyAm
JiAoIXBtX29wcy0+dmFsaWQKKwkJCXx8KHBtX29wcy0+dmFsaWQgJiYgcG1fb3BzLT52YWxpZChp
KSkpKQogCQkJcyArPSBzcHJpbnRmKHMsIiVzICIscG1fc3RhdGVzW2ldKTsKIAl9CiAJcyArPSBz
cHJpbnRmKHMsIlxuIik7CmRpZmYgLXB1TiBpbmNsdWRlL2xpbnV4L3BtLmh+cG1fc3RhdGVzX2Ns
ZWFudXAgaW5jbHVkZS9saW51eC9wbS5oCi0tLSBsaW51eC0yLjYuMTQtcmMxL2luY2x1ZGUvbGlu
dXgvcG0uaH5wbV9zdGF0ZXNfY2xlYW51cAkyMDA1LTA5LTE5IDE2OjMzOjM1LjAwMDAwMDAwMCAr
MDgwMAorKysgbGludXgtMi42LjE0LXJjMS1yb290L2luY2x1ZGUvbGludXgvcG0uaAkyMDA1LTA5
LTE5IDE2OjUwOjM4LjAwMDAwMDAwMCArMDgwMApAQCAtMTcwLDYgKzE3MCw3IEBAIHR5cGVkZWYg
aW50IF9fYml0d2lzZSBzdXNwZW5kX2Rpc2tfbWV0aG8KIAogc3RydWN0IHBtX29wcyB7CiAJc3Vz
cGVuZF9kaXNrX21ldGhvZF90IHBtX2Rpc2tfbW9kZTsKKwlpbnQgKCp2YWxpZCkoc3VzcGVuZF9z
dGF0ZV90IHN0YXRlKTsKIAlpbnQgKCpwcmVwYXJlKShzdXNwZW5kX3N0YXRlX3Qgc3RhdGUpOwog
CWludCAoKmVudGVyKShzdXNwZW5kX3N0YXRlX3Qgc3RhdGUpOwogCWludCAoKmZpbmlzaCkoc3Vz
cGVuZF9zdGF0ZV90IHN0YXRlKTsKZGlmZiAtcHVOIGRyaXZlcnMvYWNwaS9zbGVlcC9tYWluLmN+
cG1fc3RhdGVzX2NsZWFudXAgZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYwotLS0gbGludXgtMi42
LjE0LXJjMS9kcml2ZXJzL2FjcGkvc2xlZXAvbWFpbi5jfnBtX3N0YXRlc19jbGVhbnVwCTIwMDUt
MDktMTkgMTY6NDI6MjYuMDAwMDAwMDAwICswODAwCisrKyBsaW51eC0yLjYuMTQtcmMxLXJvb3Qv
ZHJpdmVycy9hY3BpL3NsZWVwL21haW4uYwkyMDA1LTA5LTE5IDE2OjUxOjMzLjAwMDAwMDAwMCAr
MDgwMApAQCAtMTU4LDcgKzE1OCwxNSBAQCBpbnQgYWNwaV9zdXNwZW5kKHUzMiBhY3BpX3N0YXRl
KQogCXJldHVybiAtRUlOVkFMOwogfQogCitzdGF0aWMgaW50IGFjcGlfcG1fc3RhdGVfdmFsaWQo
c3VzcGVuZF9zdGF0ZV90IHBtX3N0YXRlKQoreworCXUzMiBhY3BpX3N0YXRlID0gYWNwaV9zdXNw
ZW5kX3N0YXRlc1twbV9zdGF0ZV07CisKKwlyZXR1cm4gc2xlZXBfc3RhdGVzW2FjcGlfc3RhdGVd
OworfQorCiBzdGF0aWMgc3RydWN0IHBtX29wcyBhY3BpX3BtX29wcyA9IHsKKwkudmFsaWQgPSBh
Y3BpX3BtX3N0YXRlX3ZhbGlkLAogCS5wcmVwYXJlID0gYWNwaV9wbV9wcmVwYXJlLAogCS5lbnRl
ciA9IGFjcGlfcG1fZW50ZXIsCiAJLmZpbmlzaCA9IGFjcGlfcG1fZmluaXNoLApfCg==

------_=_NextPart_001_01C5BCF8.93D7D823--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
