From: Kristoffer Sjoberg <kristoffer.sjoberg-lzmg0B5VUhvLoDKTGw+V6w@public.gmane.org>
Subject: Re: [patch] swsusp2 should execute _WAK on resume
Date: Tue, 08 Mar 2005 17:34:30 +0100
Message-ID: <1110299670.4887.2.camel@localhost.localdomain>
References: <422C681A.5040208@colitti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-7IqgE8WoTvrkAr/FrwtN"
In-Reply-To: <422C681A.5040208-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lorenzo Colitti <lorenzo-Z4WAQ3j+MphBDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-7IqgE8WoTvrkAr/FrwtN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Just after resume, this following message is shown in my dmesg. I have
the patch below applied. Does anyone know why a method would return
AE_TIME?

    ACPI-0405: *** Error: Handler for [EmbeddedControl] returned AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.C044.C057.C0E7.C12=
F] (Node c17efb80), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.C12F] (Node c17f45=
00), AE_TIME
    ACPI-1138: *** Error: Method execution failed [\_SB_.C137._BST] (Node c=
17f4440), AE_TIME

Thanks,

Krristoffer Sj=F6berg
Netstar AB

On m=E5n, 2005-03-07 at 15:41 +0100, Lorenzo Colitti wrote:
> Hi,
>=20
> [CCing ACPI-devel in case someone wants to comment]
>=20
> Using swsusp2 2.1.8 on a vanilla 2.6.11 kernel (but I have been seeing=20
> this since v2.1 on 2.6.9), my laptop (HP nc6000) doesn't generate any=20
> ACPI thermal events after resume. This means the fans only come on=20
> (screaming) if the CPU reaches 85 =B0C or so, which is not very healthy.
>=20
> This is due to the fact that unlike swsusp and S3, swsusp2 does not call=20
> the ACPI _WAK method, which the ACPI spec says should be called when the=20
> machine comes out of a sleep state. If I hack swsusp2 so that it calls=20
> the _WAK method on resume, the fans work correctly after resume.
>=20
> I do this via the attached hack, but I don't know much about the=20
> workings of swsusp2, so I don't know if it's the right approach. It does=20
> work for me though, and even if the details of the patch aren't right,=20
> based on my reading of the ACPI spec I think this should be done.
>=20
> Comments? Is it fit to apply to the swsusp2 tree?
>=20
>=20
> Cheers,
> Lorenzo
>=20
> P.S. I have been using swsusp2 since v2.1 for 2.6.9, and it works like a=20
> charm. A big thank you to the people that made it possible. :)
> plain text document attachment (patch-swsusp2-acpiwakeonresume.diff)
> diff -u linux-2.6.11/kernel/power/suspend2_core/suspend.c linux-2.6.11-pa=
tched/kernel/power/suspend2_core/suspend.c
> --- linux-2.6.11/kernel/power/suspend2_core/suspend.c	2005-03-07 15:17:31=
.000000000 +0100
> +++ linux-2.6.11-patched/kernel/power/suspend2_core/suspend.c	2005-03-07 =
15:18:47.000000000 +0100
> @@ -404,6 +404,10 @@
>   * Called From     : do_suspend2_lowlevel
>   */
> =20
> +#ifdef CONFIG_ACPI
> +extern u32 acpi_leave_sleep_state (u8 sleep_state);
> +#endif
> +
>  static void do_suspend2_resume_2(void)
>  {
>  	set_suspend_state(SUSPEND_NOW_RESUMING);
> @@ -433,6 +437,11 @@
>  	suspend_checksum_print_differences();
> =20
>  	prepare_status(0, 0, "Cleaning up...");
> +
> +#ifdef CONFIG_ACPI
> +	if (suspend_powerdown_method)
> +		acpi_leave_sleep_state(suspend_powerdown_method);
> +#endif
>  }
> =20
>  /*

--=-7IqgE8WoTvrkAr/FrwtN
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJGTCCAucw
ggJQoAMCAQICAw3iRTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI1MTIzMTQ2WhcNMDYwMTI1MTIzMTQ2WjBPMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSwwKgYJKoZIhvcNAQkBFh1rcmlzdG9mZmVyLnNqb2Jl
cmdAbmV0c3Rhci5zZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANzM1JKzLvxOJf9r
hD4j+a70rxJUJU4QlM37aJgTKBF84DkGqfH4VVMO/6Jo9oUmLzmcS4CMHZrnMQBPdjet33nf80vw
2rSbmolXGG0EcyaJ8PwVjkq0+RZOLpX7CUUiMOUwyda2sgGzKK1iGjZwBNUcsZER6A3rXLCi0O9d
9tBeBOSISnS4axxrxzCVaMslC1BwYXwZUoeQ4++dMi/ZhEfGBDy0UmRch7+qV2tZ6eAO9xR3rrQM
23JxOJ6PoQ3wrRvrYtoIt/dpmevRv3l5/4YZqHLcAQKDVuTb2Ka7HLVGOfUSzO+h++92u1NWwylZ
DcX7S4rd+TX8XliqgFhHRNsCAwEAAaM6MDgwKAYDVR0RBCEwH4Eda3Jpc3RvZmZlci5zam9iZXJn
QG5ldHN0YXIuc2UwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQAJTeR8wW2OVZCSddz5
D+wO0kN06EC8Ay4uqYleJhKiKbzLkvnh0qeZq764N060QCvfQJg9aUKXFV2suAtxoCVK1auFN/m0
UbqQBHQBc04BxmS/3q1fn4TrNPVhIDPKeVSCQ/0eJ/AhVKp6B05UN2263rlXIuqLXArQm74Wn4Bq
DjCCAucwggJQoAMCAQICAw3iRTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI1MTIzMTQ2WhcNMDYwMTI1MTIzMTQ2WjBPMR8w
HQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSwwKgYJKoZIhvcNAQkBFh1rcmlzdG9mZmVy
LnNqb2JlcmdAbmV0c3Rhci5zZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANzM1JKz
LvxOJf9rhD4j+a70rxJUJU4QlM37aJgTKBF84DkGqfH4VVMO/6Jo9oUmLzmcS4CMHZrnMQBPdjet
33nf80vw2rSbmolXGG0EcyaJ8PwVjkq0+RZOLpX7CUUiMOUwyda2sgGzKK1iGjZwBNUcsZER6A3r
XLCi0O9d9tBeBOSISnS4axxrxzCVaMslC1BwYXwZUoeQ4++dMi/ZhEfGBDy0UmRch7+qV2tZ6eAO
9xR3rrQM23JxOJ6PoQ3wrRvrYtoIt/dpmevRv3l5/4YZqHLcAQKDVuTb2Ka7HLVGOfUSzO+h++92
u1NWwylZDcX7S4rd+TX8XliqgFhHRNsCAwEAAaM6MDgwKAYDVR0RBCEwH4Eda3Jpc3RvZmZlci5z
am9iZXJnQG5ldHN0YXIuc2UwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQAJTeR8wW2O
VZCSddz5D+wO0kN06EC8Ay4uqYleJhKiKbzLkvnh0qeZq764N060QCvfQJg9aUKXFV2suAtxoCVK
1auFN/m0UbqQBHQBc04BxmS/3q1fn4TrNPVhIDPKeVSCQ/0eJ/AhVKp6B05UN2263rlXIuqLXArQ
m74Wn4BqDjCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUw
EwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3Rl
IENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29u
YWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIx
CzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYD
VQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQ
CjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16em
u59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEA
MEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZy
ZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0
ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/
TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6M
IE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggLnMIIC4wIBATBp
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSww
KgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDeJFMAkGBSsOAwIa
BQCgggFTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MDMwODE2
MzQyOFowIwYJKoZIhvcNAQkEMRYEFCh04LQBl3RpcdjMhPXRCZETUeBjMHgGCSsGAQQBgjcQBDFr
MGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMN4kUwegYLKoZI
hvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAo
UHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQID
DeJFMA0GCSqGSIb3DQEBAQUABIIBADe+Jwzkwop7fHW2T1ioJS+GfPNBRAqEzhiobEHxQvsCndzW
HLqFkMBi4xaHmf+wikPw5MrNcHjgE2yLFP1mcehx9RECL585wGUTfctbt+5WOUf6nd4D9zJazotW
wjzp2Ri6HfDsK2BT+AH2Hphwrd89iAa0RGnd/nmqjVpRj6jVp8MWOGUoXszWaMFD7SIjdg9WmHvD
yGE7L2Uf8wx5DWdg3QqKZzjPnryehEc9F2CbO4R8lDTjuFUp76xQfEQkdvKik+HWHz9G42HNu6IM
06pw5Pd/v57SsHCHQf2ElQCS9IARByNHk4w3IGKXqOTM2Klj/1m8jymLezObGmRdQi4AAAAAAAA=


--=-7IqgE8WoTvrkAr/FrwtN--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
