From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: [Fwd: [patch 2.6.18-rc7] ACPI: build warnings begone (x86_64)]
Date: Wed, 20 Sep 2006 02:29:48 +0100
Message-ID: <1158715788.3098.24.camel@localhost.portugal>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-X8ZTyAZOuY8275Ycj11E"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from a83-132-128-147.cpe.netcabo.pt ([83.132.128.147]:53157 "EHLO
	localhost.portugal") by vger.kernel.org with ESMTP id S1750726AbWITBaA
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Sep 2006 21:30:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: acpi devel <linux-acpi@vger.kernel.org>
Cc: David Brownell <david-b@pacbell.net>


--=-X8ZTyAZOuY8275Ycj11E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi, I think this should be reported on=20
ACPI mailing list , so I am Forwarding to this list=20

-------- Forwarded Message --------
> From: David Brownell <david-b@pacbell.net>
> To: Brown, Len <len.brown@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: [patch 2.6.18-rc7] ACPI: build warnings begone (x86_64)
> Date: 	Wed, 13 Sep 2006 21:00:33 -0700
>=20
> This makes various ACPI compiler warnings go away (x86_64),
> making builds be warning-free again.
>=20
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>=20
> Index: g26/drivers/acpi/executer/exmutex.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- g26.orig/drivers/acpi/executer/exmutex.c	2006-07-14 10:03:04.00000000=
0 -0700
> +++ g26/drivers/acpi/executer/exmutex.c	2006-09-13 13:31:10.000000000 -07=
00
> @@ -266,10 +266,10 @@ acpi_ex_release_mutex(union acpi_operand
>  	     walk_state->thread->thread_id)
>  	    && (obj_desc->mutex.os_mutex !=3D ACPI_GLOBAL_LOCK)) {
>  		ACPI_ERROR((AE_INFO,
> -			    "Thread %X cannot release Mutex [%4.4s] acquired by thread %X",
> -			    (u32) walk_state->thread->thread_id,
> +			    "Thread %p cannot release Mutex [%4.4s] acquired by thread %p",
> +			    walk_state->thread->thread_id,
>  			    acpi_ut_get_node_name(obj_desc->mutex.node),
> -			    (u32) obj_desc->mutex.owner_thread->thread_id));
> +			    obj_desc->mutex.owner_thread->thread_id));
>  		return_ACPI_STATUS(AE_AML_NOT_OWNER);
>  	}
> =20
> Index: g26/drivers/acpi/tables/tbget.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- g26.orig/drivers/acpi/tables/tbget.c	2006-07-14 10:03:04.000000000 -0=
700
> +++ g26/drivers/acpi/tables/tbget.c	2006-09-13 13:37:27.000000000 -0700
> @@ -324,7 +324,7 @@ acpi_tb_get_this_table(struct acpi_point
> =20
>  	if (header->length < sizeof(struct acpi_table_header)) {
>  		ACPI_ERROR((AE_INFO,
> -			    "Table length (%X) is smaller than minimum (%X)",
> +			    "Table length (%X) is smaller than minimum (%zX)",
>  			    header->length, sizeof(struct acpi_table_header)));
> =20
>  		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
> Index: g26/drivers/acpi/utilities/utmutex.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- g26.orig/drivers/acpi/utilities/utmutex.c	2006-07-14 10:03:04.0000000=
00 -0700
> +++ g26/drivers/acpi/utilities/utmutex.c	2006-09-13 13:39:24.000000000 -0=
700
> @@ -258,8 +258,8 @@ acpi_status acpi_ut_acquire_mutex(acpi_m
>  		acpi_gbl_mutex_info[mutex_id].thread_id =3D this_thread_id;
>  	} else {
>  		ACPI_EXCEPTION((AE_INFO, status,
> -				"Thread %X could not acquire Mutex [%X]",
> -				(u32) this_thread_id, mutex_id));
> +				"Thread %p could not acquire Mutex [%X]",
> +				this_thread_id, mutex_id));
>  	}
> =20
>  	return (status);
> Index: g26/drivers/acpi/tables/tbrsdt.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- g26.orig/drivers/acpi/tables/tbrsdt.c	2006-07-14 10:03:04.000000000 -=
0700
> +++ g26/drivers/acpi/tables/tbrsdt.c	2006-09-13 13:38:39.000000000 -0700
> @@ -187,7 +187,7 @@ acpi_status acpi_tb_validate_rsdt(struct
> =20
>  	if (table_ptr->length < sizeof(struct acpi_table_header)) {
>  		ACPI_ERROR((AE_INFO,
> -			    "RSDT/XSDT length (%X) is smaller than minimum (%X)",
> +			    "RSDT/XSDT length (%X) is smaller than minimum (%zX)",
>  			    table_ptr->length,
>  			    sizeof(struct acpi_table_header)));
> =20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
S=E9rgio M.B.

--=-X8ZTyAZOuY8275Ycj11E
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjA5MjAwMTI5NDhaMCMGCSqGSIb3DQEJBDEWBBSnU62eXrpPgMDmPZzeHH7i
bELiXzANBgkqhkiG9w0BAQEFAASCAQBGD+W6Az76exXYeiqr86SfiE32fDLtkAhqCbSONPmLaD/6
KAmHcgHiG9Hzg1WGS4DfmWyIM3eJm4EqhTZfDCL2XQQImZdTNZOOEcTzdQBg7iUh3JBrJzBEhPr9
mcL9q5/ZZ1FS+8JfNHDgjCr/fkSvx0wYjS5E9OJkFgD85/NLy5TaELsMPGFs3xE3OBZQfVUItUvn
0PXCqUhdCuE1bLPyUXYF2NNdRltfwme4DeGlH/lzmt6My5oQK/n7DsmTvbaWZDDnJnjFZVkK30op
NzENQOeXsdTJh92Iv7g8YdBcJ9FO7C+HnYgyQDdZ0DKZWx3LqMs+UJJ4tkQ6+RYhNuUzAAAAAAAA



--=-X8ZTyAZOuY8275Ycj11E--

