From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau-Qt13gs6zZMY@public.gmane.org>
Subject: [PATCH][2.4] acpi S5 poweroff fix
Date: Tue, 29 Apr 2003 20:15:18 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030429181518.96485.qmail@web41601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1116724786-1051640118=:95381"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--0-1116724786-1051640118=:95381
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hello Andy,

since I have this new laptop (sony vaio pcg-fx705), ACPI has never allowed
me to shutdown correctly. It always hangs and I have to maintain the power
button pressed to power off, whatever the version of your acpi patch I was
using. Today, I had a bit of free time, so I investigated into the code and
finally fixed the problem :-)

Basically, two unrelated things :
1) I noticed that "echo 5 >/proc/acpi/sleep" would oops, so I manually copied
   the oops and discovered that acpi_restore_state_mem() crashed, trying to
   affet 'pmd' a NULL value. Then I realized that it was because on this path,
   acpi_save_state_mem() was never called in S5. I first thought this was
   intentional because S5 is not expected to return, but reading through the
   code, I found a conflict such as "if (state < 5) { ... if (state != 5) ..."
   so I was sure that the first one should have included 5, and I changed the
   '<' to '<=' so that acpi_save_state_mem() is now called.
   It still didn't work, and I noticed that in acpi_suspend(), the call to
   acpi_system_suspend() is expected to do the right job and certainly not to
   return. But acpi_system_suspend() does nothing if called with state=5 !
   So I added the check for ACPI_STATE_S5 at the same level as _S1 because it
   semt right to me.
   => with these 2 changes, echoing 5 in /proc/acpi/sleep now turns my notebook
   OFF !!!
   => I diffed original (20030424) and my changes and put them in the first
      attached patch.

2) The sad thing is that even after that, neither Alt-SysRq-O nor halt would
   power off. I saw that acpi_poweroff() was a simpler than the code path
   executed from acpi_suspend(5). I tried to duplicate part of the code, but
   no lock. I think I missed some bits. So I did it far simpler : now
   acpi_poweroff() only calls acpi_suspend(ACPI_STATE_S5) and everything works
   fine !  => hence the second patch, still against 20030424.

Although I'm not sure that the second case affects everybody, because it might
be caused by side-effects, but from what I've understood from the code, I'm
pretty sure that nobody can power off by echoing 5 to /proc/acpi/sleep !

Here are the two patches, please review them and apply them if you agree !

Cheers,
Willy (happy with a notebook that powers down for the first time in months !)


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
--0-1116724786-1051640118=:95381
Content-Type: application/octet-stream; name="acpi-20030424-S5-fix.diff"
Content-Transfer-Encoding: base64
Content-Description: acpi-20030424-S5-fix.diff
Content-Disposition: attachment; filename="acpi-20030424-S5-fix.diff"

LS0tIC4vZHJpdmVycy9hY3BpL3N5c3RlbS5jLW9yaWcJVHVlIEFwciAyOSAx
NzozOTozNCAyMDAzCisrKyAuL2RyaXZlcnMvYWNwaS9zeXN0ZW0uYwlUdWUg
QXByIDI5IDE5OjA4OjA5IDIwMDMKQEAgLTE4MCw3ICsxODAsNyBAQAogCQkJ
cmV0dXJuIEFFX0VSUk9SOwogCX0KIAotCWlmIChzdGF0ZSA8IEFDUElfU1RB
VEVfUzUpIHsKKwlpZiAoc3RhdGUgPD0gQUNQSV9TVEFURV9TNSkgewogCQkv
KiBUZWxsIGRldmljZXMgdG8gc3RvcCBJL08gYW5kIGFjdHVhbGx5IHNhdmUg
dGhlaXIgc3RhdGUuCiAJCSAqIEl0IGlzIHRoZW9yZXRpY2FsbHkgcG9zc2li
bGUgdGhhdCBzb21ldGhpbmcgY291bGQgZmFpbCwKIAkJICogc28gaGFuZGxl
IHRoYXQgZ3JhY2VmdWxseS4uCkBAIC0yNzcsNiArMjc3LDcgQEAKIAogCXN3
aXRjaCAoc3RhdGUpIHsKIAljYXNlIEFDUElfU1RBVEVfUzE6CisJY2FzZSBB
Q1BJX1NUQVRFX1M1OgogCQliYXJyaWVyKCk7CiAJCXN0YXR1cyA9IGFjcGlf
ZW50ZXJfc2xlZXBfc3RhdGUoc3RhdGUpOwogCQlicmVhazsK

--0-1116724786-1051640118=:95381
Content-Type: application/octet-stream; name="acpi-20030424-pwoff-use-suspend.diff"
Content-Transfer-Encoding: base64
Content-Description: acpi-20030424-pwoff-use-suspend.diff
Content-Disposition: attachment; filename="acpi-20030424-pwoff-use-suspend.diff"

LS0tIC4vZHJpdmVycy9hY3BpL3N5c3RlbS5jLXdvcmtpbmcJVHVlIEFwciAy
OSAxOTowOToxOSAyMDAzCisrKyAuL2RyaXZlcnMvYWNwaS9zeXN0ZW0uYwlU
dWUgQXByIDI5IDE5OjM2OjA4IDIwMDMKQEAgLTkwLDkgKzkwLDcgQEAKIHN0
YXRpYyB2b2lkCiBhY3BpX3Bvd2VyX29mZiAodm9pZCkKIHsKLQlhY3BpX2Vu
dGVyX3NsZWVwX3N0YXRlX3ByZXAoQUNQSV9TVEFURV9TNSk7Ci0JQUNQSV9E
SVNBQkxFX0lSUVMoKTsKLQlhY3BpX2VudGVyX3NsZWVwX3N0YXRlKEFDUElf
U1RBVEVfUzUpOworCWFjcGlfc3VzcGVuZChBQ1BJX1NUQVRFX1M1KTsKIH0K
IAogI2VuZGlmIC8qQ09ORklHX1BNKi8K

--0-1116724786-1051640118=:95381--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
