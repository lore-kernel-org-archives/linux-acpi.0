From: Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] Alexander Malysh's forgotten acpi_leave_sleep_state() IRQ patch
Date: Sat, 01 May 2004 23:08:07 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040501230315.33BD.COUNT0@localnet.com>
References: <1083462390.5866.10.camel@nala>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------_409464F133BA01B3C540_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1083462390.5866.10.camel-7YzDMyNdTwE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--------_409464F133BA01B3C540_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Feb 14, Alexander Malysh wrote:
> We disable non wakeup gpes (and store those values) with interrupts disabled, 
> but enable those with interrupts enabled which were already overwritten while 
> handling of wakeup interrupt. So we must restore non wakeup gpes as long 
> interrupts are disabled.

The second half of his patch never made it into 2.6.5, and remains
necessary. Without this patch my N258SA0 is dead on resume, requiring
removal of battery and mains power cable to get it back. With this patch,
I get some improvement. Attached.
-- 
Huw Rogers <count0-tC47gz4GrgtWk0Htik3J/w@public.gmane.org>

--------_409464F133BA01B3C540_MULTIPART_MIXED_
Content-Type: application/octet-stream; name="acpi_leave_sleep_state_irq_fix.diff"
Content-Disposition: attachment;
 filename="acpi_leave_sleep_state_irq_fix.diff"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi41L2RyaXZlcnMvYWNwaS9zbGVlcC9tYWluLmMub3JpZwkyMDA0LTA1LTAx
IDIyOjM0OjExLjAwMDAwMDAwMCAtMDQwMAorKysgbGludXgtMi42LjUvZHJpdmVycy9hY3BpL3Ns
ZWVwL21haW4uYwkyMDA0LTA1LTAxIDIyOjM0OjUyLjAwMDAwMDAwMCAtMDQwMApAQCAtMTA3LDcg
KzEwNyw2IEBACiAJZGVmYXVsdDoKIAkJcmV0dXJuIC1FSU5WQUw7CiAJfQotCWxvY2FsX2lycV9y
ZXN0b3JlKGZsYWdzKTsKIAlwcmludGsoS0VSTl9ERUJVRyAiQmFjayB0byBDIVxuIik7CiAKIAkv
KiByZXN0b3JlIHByb2Nlc3NvciBzdGF0ZQpAQCAtMTE4LDYgKzExNyw4IEBACiAJaWYgKHN0YXRl
ID4gUE1fU1VTUEVORF9TVEFOREJZKQogCQlhY3BpX3Jlc3RvcmVfc3RhdGVfbWVtKCk7CiAKKwlh
Y3BpX2xlYXZlX3NsZWVwX3N0YXRlKHN0YXRlKTsKKwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7
CiAKIAlyZXR1cm4gQUNQSV9TVUNDRVNTKHN0YXR1cykgPyAwIDogLUVGQVVMVDsKIH0KQEAgLTEz
Myw4ICsxMzQsNiBAQAogCiBzdGF0aWMgaW50IGFjcGlfcG1fZmluaXNoKHUzMiBzdGF0ZSkKIHsK
LQlhY3BpX2xlYXZlX3NsZWVwX3N0YXRlKHN0YXRlKTsKLQogCS8qIHJlc2V0IGZpcm13YXJlIHdh
a2luZyB2ZWN0b3IgKi8KIAlhY3BpX3NldF9maXJtd2FyZV93YWtpbmdfdmVjdG9yKChhY3BpX3Bo
eXNpY2FsX2FkZHJlc3MpIDApOwogCg==

--------_409464F133BA01B3C540_MULTIPART_MIXED_--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
