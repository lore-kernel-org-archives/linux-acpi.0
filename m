From: Emilio Mejia Fernandez de Velasco <emejia-EkmVulN54Sk@public.gmane.org>
Subject: Re: RV: differences between acpidump and disassembling
Date: Wed, 21 Apr 2004 01:18:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200404210118.17337.emejia@ieee.org>
References: <000701c425f8$6157aef0$0301a8c0@portatil> <200404192343.11269.emejia@ieee.org> <1082487806.28680.8.camel@darkstar>
Reply-To: emejia-EkmVulN54Sk@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4+ahAGoEtfifPMD"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1082487806.28680.8.camel-4/PLUo9XfK8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_4+ahAGoEtfifPMD
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

El Martes, 20 de Abril de 2004 21:03, S=E9rgio Monteiro Basto escribi=F3:
> Hello You have very similar to mine :)
>
> when you compile the kernel you must disable SMP, IO-APIC and LOCAL
> APIC, in menu  "Processor type and features" to work with ACPI.
> (use make xconfig)
>
> Please send me the output /sbin/lspci and /sbin/lspci -n
>
> You must disable Advance Program Interrupt Control.
>
Now I don't know what else I can do. Here I send you the results of lspci a=
nd=20
lspci -n, and also the configuration file to compile the kernel 2.6.4, whic=
h=20
is very similar to the one that I used for 2.6.5. I think I had already tak=
en=20
in account to disable SMP and APIC.
Tomorrow I will try again to compile the kernel 2.6.5. By the way, in this=
=20
last kernel, when I try to apply last acpi patch -from march 26th I think-,=
 I=20
get some hunks failed.
What should I answer when it asks me the following questions:
Reversed (or previously applied) patch detected! Assume -R? [n]
and, I usually answer n, so it asks me:
Apply anyway? [n]
and then I answer y
This is what happens when using a clean or vanilla kernel directly download=
ed=20
from kernel.org, and the acpi patch from acpi.sf.net
Anyway, I have already tried 2.6.5 with and without the acpi patch, and the=
=20
only way to get it working is without acpi options
I will send you the .config file when I compile it, so you can check out if=
=20
I'm using the right options =BFok?

Best regards,

Emilio

--Boundary-00=_4+ahAGoEtfifPMD
Content-Type: application/x-bzip2;
  name="lspci.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lspci.bz2"

QlpoOTFBWSZTWZTg4FoAAHJfgAAQQG//8D/u35o/798AQAIK7IkWGiJoTamNQYj1NAADQAaDIEom
hDQmEmj1GjQaNAaNDQPUZDmAAAAAAAAAABIkgRhRjTUA0aA00ADQATuBghy+BNLJ4GqDv4iUYEcr
j7b08kqg6mofYkpPsans7QnwQPBa38pu0PLyhsGeY5LifqRIylOiMJmKR+2sPjZAipEcNGB/KATL
JnFCgTCYNWLBFboaVJkSjXI4vDZFEgr1VcW4tE7uA1V5C604DoBYERCtJQxTAmlA5GwJOUZ3mQYs
gRVDBk2LtsykHLe4ISlGo2PhBHzUowqUMHwMWyihP5az3RIgpmqi8WlTs16RybYV5WkdKWc8rq3Y
Gwc5IjSeuYmpwRyTukRdYeZqbiZbKIM8koPTFA2C3Wa5HPJBiZVmi+C2SnNh1kgtQeMCC8YNntm6
SSNG3ufVv3o+PrYWYB47vWzSY1MJ1nyiGof0b6wJnqgoM31HvDRESESiG7epYqDc+oCFtdVt0sky
XzK5By8jwHZKwTLIRaQKjGBNFFl6ioX9kAoz1EeunCl7SDFckQMDawn15YnteR6Eh46ovApKpIHW
Og32YnMA0GBeBPhS55KE2ZuLdx3GQuC5pZQsNaRK8TLDSLWISHPcmLgJSuHvx4GfNrmgtEEBZs9s
Oa/KXH4lrCIPD+LuSKcKEhKcHAtA

--Boundary-00=_4+ahAGoEtfifPMD
Content-Type: application/x-bzip2;
  name="lspci-n.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="lspci-n.bz2"

QlpoOTFBWSZTWdMWGiQAAEJdgAAQQGF/8AgALgQZADAA+q2CRCIaJk0yAMTUT1A0AAJNUFPKaan6
o9QPaleBIeTOU1r41TZtEVYD0EQcZPSdJLOeEhw3r1BYvlJtXeXupat2BfMzpbE64056Cc6MvrB5
8WDGaF5iy1ogo4kYUscTpgqKHaXvuSrOkouxDPBFIxFr0oMEaL0cVSqUXORMANMIvGCUjARMohIy
JeSrTOBeh4stU1XAlWXUQGXrY5tbiEv3CYCndOXchuE3Idwn/CYkPYu5IpwoSGmLDRIA

--Boundary-00=_4+ahAGoEtfifPMD
Content-Type: application/x-bzip2;
  name=".config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=".config.bz2"

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

--Boundary-00=_4+ahAGoEtfifPMD--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
