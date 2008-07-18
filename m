From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: [PATCH 02/11] Check for ACPI backlight support otherwise use
	vendor ACPI drivers
Date: Fri, 18 Jul 2008 04:52:51 +0100
Message-ID: <1216353172.3779.11.camel@segulix.localdomain>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
	 <200807171552.12974.trenn@suse.de>
	 <1216351113.26321.35.camel@segulix.localdomain>
	 <200807180454.43347.trenn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-X70A32Yw+TnUD77Sdd5F"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:54885 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750903AbYGRDwz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 23:52:55 -0400
In-Reply-To: <200807180454.43347.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ak@linux.intel.com, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it


--=-X70A32Yw+TnUD77Sdd5F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Fri, 2008-07-18 at 04:54 +0200, Thomas Renninger wrote:
> On Friday 18 July 2008 05:18:32 am Sergio Monteiro Basto wrote:
> > On Thu, 2008-07-17 at 15:52 +0200, Thomas Renninger wrote:
> > > I just had a quick look on each, do not give much on above statements=
.
> > > If there is any outcome on 9642 (_DOS=3D1 works, _DOS=3D0 fails on HP=
s and
> > > LID),
> > > pls let me know.
> >
> > 9642 , is about my laptop, I will happily try yours patches , and repor=
t
> > back
> Wait..., these patches are unrelated to this one.

ok=20

> I meant: if you come further and find out something, pls tell me.
> (Theoretically we could blacklist them easily to not use display output=20
> switching with the patch, but better still try a bit).
> I know about a lot HP and others having problems with _DOS=3D0 and freezi=
ng on=20
> LID:
> https://bugzilla.novell.com/show_bug.cgi?id=3D378917 (-> a lot duplicates=
)
> https://bugzilla.novell.com/show_bug.cgi?id=3D290219

the bug=20
http://bugzilla.kernel.org/show_bug.cgi?id=3D6001=20
explain why _DOS is, by default, 0 and not 1.=20

Has I write there ,
http://bugzilla.kernel.org/show_bug.cgi?id=3D6001#c47=20
we should back to DOS=3D1 by default

Seems that you have same opinion that we should set _DOS to 1, by
default.=20

I patch the kernel myself , because fix the problem on my compaq
nx6110 , the other S=C3=A9rgio on bug 6001 , don't reply ... =20

Thanks,=20
--=20
S=C3=A9rgio M. B.

--=-X70A32Yw+TnUD77Sdd5F
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGVjCCAw8w
ggJ4oAMCAQICECv58J8+j9G8Y7r6tize4dAwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MTAxMzIyMjE1NFoXDTA4MTAxMjIyMjE1
NFowSzEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEoMCYGCSqGSIb3DQEJARYZc2Vy
Z2lvQHNlcmdpb21iLm5vLWlwLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALmR
do8nLKka6p0NNur5o8znYir80AaybL3nuKDDeY2CNjm8JdpJPea9KmXurRU9Q/jnsmgtn2UH9blF
1qUDxzUvFrZ8fEFkMBht+DJMPShJIa885JyggTvRg+ZUEPdjvb7pHrvpEhxlDcJ9vpYnB4M06D2p
lefGl9TVq9srUCUMc/4/G/OLaLz0f6Nhc0Gb7YcUDIRINHR0pWuCpxl8wxOU8YSx43KbNgPOo3Kn
jtdcgGRoy7kAKN2rQmU4tgLDh8F+f9a3mMc3YRs0CfkPq7RSGMWcNagkEWCcoh0f5tDYjq1iQEWD
5fK1esWmiR5onZ+QyUd+kU7IycY68iMD5BMCAwEAAaNZMFcwDgYDVR0PAQH/BAQDAgSQMBEGCWCG
SAGG+EIBAQQEAwIFoDAkBgNVHREEHTAbgRlzZXJnaW9Ac2VyZ2lvbWIubm8taXAub3JnMAwGA1Ud
EwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAetiCq+dKlfTpFybx+lLoL7A/ep10fER7eHDGB6MQ
9n8HDqz2eOXMZrw0WSYfWXhG+fnrpUE85DseFXQFJDf6gBdD/KlYqnmaDY0nK9LdFHA3hapRARvB
el9wYF60z+1yI69bFzyoZpCnY3+1oFQGews7kwT6u77QVdj6Y8v+Ai0wggM/MIICqKADAgECAgEN
MA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9D
ZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20w
HhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZ
Wh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuv
PAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBly
YLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRw
Oi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMC
AQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFh
YsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVN
d+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIB/DCCAfgCAQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECECv58J8+j9G8Y7r6tize4dAwCQYFKw4DAhoFAKBdMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA4MDcxODAzNTI0N1owIwYJKoZI
hvcNAQkEMRYEFODCRiuQNebdML/V+svn9ElENkV+MA0GCSqGSIb3DQEBAQUABIIBAEoJwbmh4b/Z
w/OGczYlUd4xQbrmgTOr1ZDNSjeDnDvBvhIyzlTi12+hrr/eI4eyedGB8VC8NEJ1n/YBL/RKLptN
ghjJXPfO0Dno2/6DYudpes19u5ZxDIrbgbJHRmKn6bUxmS+ELexMUCou+lk/fppYGxm6qkxGUvdU
Uh3lGKhyAAsFUSt8X57cP1x2yT+zqSkzIv62sXcT41nuca6EQTTZN7AHA1Ovvpx121Q+drCMcdw9
t2GjujNWvGDv3Ih5L2G44xF7CkDCzfRkQpRjdBqRKcio+Ugdj0XIuW8GgZAXTyJE1mndnwsT1oJ+
FqXqzZ3bTTjCHR46EknQE23PfMgAAAAAAAA=


--=-X70A32Yw+TnUD77Sdd5F--

