From: "KOCHI, Takayoshi" <t-kouchi-dPjYVeZdYcz+G+EEi5ephHgSJqDPrsil@public.gmane.org>
Subject: Re: ACPI mode change...
Date: Thu, 25 Jul 2002 14:21:14 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020725131047.F816.T-KOUCHI@mvf.biglobe.ne.jp>
References: <59885C5E3098D511AD690002A5072D3C07990D7E@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C07990D7E-OU+JdkIUtvcLll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, alex_williamson-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Thu, 25 Jul 2002 11:15:25 -0700
"Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> After reading your explanation, I'm still unclear...In light of the check=
s
> we are doing in evxfevnt.c acpi_enable(), can you explain why these 3
> additional checks are also needed? I would think that systems with 0
> fadt->acpi_enable, acpi_disable, or smi_cmd, SCI_EN would already be 1, s=
o
> hw_set_mode would never be called, yes?
>=20
> Regards -- Andy

Okay, I'll change the viewpoint.  Forget about my last argument:)

=46rom the name of acpi_enable() and acpi_disable() API,
one will assume they correspond to ACPI_ENABLE
and ACPI_DISABLE of FADT.  But actual behavior is not.
It's misleading.

acpi_disable() sounds that it means "Turn the system into LEGACY
mode", but turns into its original mode recorded at
acpi_enable().  So if the original mode is ACPI it will not
_disable_ ACPI mode anyway:)
And as acpi_disable() uninstalls the SCI handler,
acpi_enable() and acpi_disable() are not symmetrical, either.

In my opinion,
1) setting acpi_gbl_original_mode should be done outside
   acpi_enable()
   (In case someone erroneously call acpi_enable() twice
    and acpi_disable()...)
2) acpi_disable() should just disable ACPI mode
3) whether disabling ACPI mode or not should be determined
   outside acpi_disable().
4) rewrite reference manual so that it reflects correct behavior
   of AcpiEnable and AcpiDisable

And then, acpi_enable() and acpi_disable() will be simple wrappers
for acpi_hw_set_mode().  Then, discussion about whether we should
check FADT's ACPI_ENABLE, ACPI_DISABLE and SMI_CMD would
make sense...

Thanks,
--=20
KOCHI, Takayoshi <t-kouchi-f7IHDacdhdx8UrSeD/g0lQ@public.gmane.org/t-kouchi>



-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
