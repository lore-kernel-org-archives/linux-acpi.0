From: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH][BUG] LoadTable() operator fails
Date: Fri, 07 Jan 2005 11:14:39 +0900
Message-ID: <41DDF08F.6030800@jp.fujitsu.com>
References: <41DB7B2A.4020005@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050501060300010703040809"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41DB7B2A.4020005-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------050501060300010703040809
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

My mailer inserted unnecessary line feeds into the patch.
So I send it again.

Thanks,
Kenji Kaneshige

Kenji Kaneshige wrote:
> Hi,
> 
> The execution of the LoadTable() operator might fail because of the
> bug on OEM ID comparison. The following patch fixes this issue.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> 
> 
> ---
> 
>  linux-2.6.10-kanesige/drivers/acpi/tables/tbxfroot.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/tables/tbxfroot.c~fix_acpi_tb_find_table
> drivers/acpi/tables/tbxfroot.c
> --- linux-2.6.10/drivers/acpi/tables/tbxfroot.c~fix_acpi_tb_find_table
> 2005-01-04 09:05:29.000000000 +0900
> +++ linux-2.6.10-kanesige/drivers/acpi/tables/tbxfroot.c	2005-01-04
> 09:05:29.000000000 +0900
> @@ -114,8 +114,8 @@ acpi_tb_find_table (
> 
>  	/* Check oem_id and oem_table_id */
> 
> -	if ((oem_id[0]     && ACPI_STRCMP (oem_id, table->oem_id)) ||
> -		(oem_table_id[0] && ACPI_STRCMP (oem_table_id, table->oem_table_id))) {
> +	if ((oem_id[0]     && ACPI_STRNCMP (oem_id, table->oem_id, sizeof
> (table->oem_id))) ||
> +		(oem_table_id[0] && ACPI_STRNCMP (oem_table_id, table->oem_table_id,
> sizeof (table->oem_table_id)))) {
>  		return_ACPI_STATUS (AE_AML_NAME_NOT_FOUND);
>  	}
> 
> 
> _
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


--------------050501060300010703040809
Content-Type: text/plain;
 name="fix_acpi_tb_find_table.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fix_acpi_tb_find_table.patch"

ClRoZSBleGVjdXRpb24gb2YgdGhlIExvYWRUYWJsZSgpIG9wZXJhdG9yIG1pZ2h0IGZhaWwg
YmVjYXVzZSBvZiB0aGUKYnVnIG9uIE9FTSBJRCBjb21wYXJpc29uLiBUaGUgZm9sbG93aW5n
IHBhdGNoIGZpeGVzIHRoaXMgaXNzdWUuCgpTaWduZWQtb2ZmLWJ5OiBLZW5qaSBLYW5lc2hp
Z2UgPGthbmVzaGlnZS5rZW5qaUBqcC5mdWppdHN1LmNvbT4KCgotLS0KCiBsaW51eC0yLjYu
MTAta2FuZXNpZ2UvZHJpdmVycy9hY3BpL3RhYmxlcy90Ynhmcm9vdC5jIHwgICAgNCArKy0t
CiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLXB1TiBkcml2ZXJzL2FjcGkvdGFibGVzL3RieGZyb290LmN+Zml4X2FjcGlfdGJfZmlu
ZF90YWJsZSBkcml2ZXJzL2FjcGkvdGFibGVzL3RieGZyb290LmMKLS0tIGxpbnV4LTIuNi4x
MC9kcml2ZXJzL2FjcGkvdGFibGVzL3RieGZyb290LmN+Zml4X2FjcGlfdGJfZmluZF90YWJs
ZQkyMDA1LTAxLTA0IDA5OjA1OjI5LjAwMDAwMDAwMCArMDkwMAorKysgbGludXgtMi42LjEw
LWthbmVzaWdlL2RyaXZlcnMvYWNwaS90YWJsZXMvdGJ4ZnJvb3QuYwkyMDA1LTAxLTA0IDA5
OjA1OjI5LjAwMDAwMDAwMCArMDkwMApAQCAtMTE0LDggKzExNCw4IEBAIGFjcGlfdGJfZmlu
ZF90YWJsZSAoCiAKIAkvKiBDaGVjayBvZW1faWQgYW5kIG9lbV90YWJsZV9pZCAqLwogCi0J
aWYgKChvZW1faWRbMF0gICAgICYmIEFDUElfU1RSQ01QIChvZW1faWQsIHRhYmxlLT5vZW1f
aWQpKSB8fAotCQkob2VtX3RhYmxlX2lkWzBdICYmIEFDUElfU1RSQ01QIChvZW1fdGFibGVf
aWQsIHRhYmxlLT5vZW1fdGFibGVfaWQpKSkgeworCWlmICgob2VtX2lkWzBdICAgICAmJiBB
Q1BJX1NUUk5DTVAgKG9lbV9pZCwgdGFibGUtPm9lbV9pZCwgc2l6ZW9mICh0YWJsZS0+b2Vt
X2lkKSkpIHx8CisJCShvZW1fdGFibGVfaWRbMF0gJiYgQUNQSV9TVFJOQ01QIChvZW1fdGFi
bGVfaWQsIHRhYmxlLT5vZW1fdGFibGVfaWQsIHNpemVvZiAodGFibGUtPm9lbV90YWJsZV9p
ZCkpKSkgewogCQlyZXR1cm5fQUNQSV9TVEFUVVMgKEFFX0FNTF9OQU1FX05PVF9GT1VORCk7
CiAJfQogCgpfCg==
--------------050501060300010703040809--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
