From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: kacpi_notify_wq and kacpid_wq use a lot of cpu
Date: Fri, 22 Jan 2010 21:53:02 +0300
Message-ID: <4B59F40E.2090102@suse.de>
References: <4b59efdb.E0ClbTr8sKopLDl5JyKeEOdy@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756274Ab0AVSxK@vger.kernel.org>
In-Reply-To: <4b59efdb.E0ClbTr8sKopLDl5JyKeEOdy@lilem.mirepesht>
Sender: linux-kernel-owner@vger.kernel.org
To: Ali Gholami Rudi <ali@rudi.ir>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Ali Gholami Rudi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi,
>=20
> Sometimes kacpi_notify_wq and kacpid_wq workqueues use a lot of cpu.
>=20
> I'm using yesterday's tip.  At times kacpi_notify_wq uses 30-50% of
> my cpu and kacpid_wq uses 3-5%:
>=20
> # uptime
>  12:49:54 up  4:16,  1 user,  load average: 0.52, 0.55, 0.40
> # ps -e | grep kacpi
>   189 ?        00:00:52 kacpid
>   190 ?        00:10:26 kacpi_notify
>   191 ?        00:00:00 kacpi_hotplug
>=20
> This sometimes happens after a few hours of uptime; so this is
> very hard to bisect (by the way, I think the same thing causes
> the fans to work fullspeed sometimes when I reboot the machine).
> I tried this patch to find out which of the callers of
> acpi_os_execute() is the culprit:
>=20
> =3D=3D=3D patch =3D=3D=3D=3D
> diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.=
c
> index afacf44..eded044 100644
> --- a/drivers/acpi/acpica/evgpe.c
> +++ b/drivers/acpi/acpica/evgpe.c
> @@ -504,6 +504,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_exec=
ute_gpe_method(void *context)
>  	acpi_status status;
>  	struct acpi_gpe_event_info local_gpe_event_info;
>  	struct acpi_evaluate_info *info;
> +	printk("acpi_ev_asynch_execute_gpe_method\n");
> =20
>  	ACPI_FUNCTION_TRACE(ev_asynch_execute_gpe_method);
> =20
> @@ -577,6 +578,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_exec=
ute_gpe_method(void *context)
>  static void acpi_ev_asynch_enable_gpe(void *context)
>  {
>  	struct acpi_gpe_event_info *gpe_event_info =3D context;
> +	printk("acpi_ev_asynch_enable_gpe\n");
>  	acpi_status status;
>  	if ((gpe_event_info->flags & ACPI_GPE_XRUPT_TYPE_MASK) =3D=3D
>  	    ACPI_GPE_LEVEL_TRIGGERED) {
> diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmis=
c.c
> index ce224e1..e2307d1 100644
> --- a/drivers/acpi/acpica/evmisc.c
> +++ b/drivers/acpi/acpica/evmisc.c
> @@ -224,6 +224,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_notify_disp=
atch(void *context)
>  	acpi_notify_handler global_handler =3D NULL;
>  	void *global_context =3D NULL;
>  	union acpi_operand_object *handler_obj;
> +	printk("acpi_ev_notify_dispatch\n");
> =20
>  	ACPI_FUNCTION_ENTRY();
> =20
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index fd1801b..f3d8cc1 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -514,6 +514,7 @@ static void acpi_ec_gpe_query(void *ec_cxt)
>  	struct acpi_ec *ec =3D ec_cxt;
>  	u8 value =3D 0;
>  	struct acpi_ec_query_handler *handler, copy;
> +	printk("acpi_ec_gpe_query\n");
> =20
>  	if (!ec || acpi_ec_query(ec, &value))
>  		return;
> diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
> index d933980..99f39db 100644
> --- a/drivers/acpi/sbshc.c
> +++ b/drivers/acpi/sbshc.c
> @@ -217,6 +217,7 @@ EXPORT_SYMBOL_GPL(acpi_smbus_unregister_callback)=
;
>  static inline void acpi_smbus_callback(void *context)
>  {
>  	struct acpi_smb_hc *hc =3D context;
> +	printk("acpi_smbus_callback\n");
>  	if (hc->callback)
>  		hc->callback(hc->context);
>  }
> =3D=3D=3D patch =3D=3D=3D=3D
>=20
> This was produced when the kacpi_notify high cpu usage happened:
>=20
> =3D=3D=3D dmesg =3D=3D=3D=3D
> ..
> [12786.473794] acpi_ev_asynch_enable_gpe
> [12786.473803] acpi_ev_notify_dispatch
> [12786.476741] acpi_ev_asynch_execute_gpe_method
> [12786.477109] acpi_ev_notify_dispatch
> [12786.482973] acpi_ev_asynch_enable_gpe
> [12786.482982] acpi_ev_notify_dispatch
> [12786.483033] acpi_ev_asynch_execute_gpe_method
> [12786.489049] acpi_ev_notify_dispatch
> [12786.494038] acpi_ev_asynch_enable_gpe
> [12786.494083] acpi_ev_asynch_execute_gpe_method
> [12786.494434] acpi_ev_notify_dispatch
> [12786.496798] acpi_ev_asynch_enable_gpe
> [12786.496845] acpi_ev_asynch_execute_gpe_method
> [12786.497210] acpi_ev_notify_dispatch
> [12786.503034] acpi_ev_asynch_enable_gpe
> [12786.503043] acpi_ev_notify_dispatch
> [12786.504363] acpi_ev_asynch_execute_gpe_method
> [12786.505198] acpi_ev_notify_dispatch
> [12786.511051] acpi_ev_asynch_enable_gpe
> [12786.511093] acpi_ev_notify_dispatch
> [12786.511100] acpi_ev_asynch_execute_gpe_method
> [12786.517091] acpi_ev_notify_dispatch
> [12786.518697] acpi_ev_asynch_enable_gpe
> [12786.518706] acpi_ev_notify_dispatch
> [12786.524051] acpi_ev_asynch_execute_gpe_method
> [12786.524409] acpi_ev_notify_dispatch
> [12786.530079] acpi_ev_asynch_enable_gpe
> [12786.530089] acpi_ev_notify_dispatch
> [12786.530128] acpi_ev_asynch_execute_gpe_method
> [12786.536094] acpi_ev_notify_dispatch
> [12786.537761] acpi_ev_asynch_enable_gpe
> [12786.537770] acpi_ev_notify_dispatch
> [12786.537936] acpi_ev_asynch_execute_gpe_method
> [12786.543131] acpi_ev_notify_dispatch
> [12786.545642] acpi_ev_asynch_enable_gpe
> [12786.545651] acpi_ev_notify_dispatch
> [12786.545692] acpi_ev_asynch_execute_gpe_method
> [12786.552133] acpi_ev_notify_dispatch
> [12786.557167] acpi_ev_asynch_enable_gpe
> [12786.557176] acpi_ev_notify_dispatch
> [12786.557215] acpi_ev_asynch_execute_gpe_method
> [12786.560062] acpi_ev_notify_dispatch
> [12786.565185] acpi_ev_asynch_enable_gpe
> [12786.565227] acpi_ev_notify_dispatch
> [12786.565234] acpi_ev_asynch_execute_gpe_method
> [12786.571202] acpi_ev_notify_dispatch
> [12786.572811] acpi_ev_asynch_enable_gpe
> [12786.575307] acpi_ev_asynch_execute_gpe_method
> [12786.575664] acpi_ev_notify_dispatch
> [12786.581250] acpi_ev_asynch_enable_gpe
> [12786.581260] acpi_ev_notify_dispatch
> [12786.581307] acpi_ev_asynch_execute_gpe_method
> [12786.587251] acpi_ev_notify_dispatch
> [12786.588854] acpi_ev_asynch_enable_gpe
> [12786.588863] acpi_ev_notify_dispatch
> [12786.822334] acpi_ev_asynch_execute_gpe_method
> [12786.822710] acpi_ev_notify_dispatch
> [12786.828829] acpi_ev_asynch_enable_gpe
> [12786.828838] acpi_ev_notify_dispatch
> [12786.828881] acpi_ev_asynch_execute_gpe_method
> [12786.833867] acpi_ev_notify_dispatch
> [12786.836233] acpi_ev_asynch_enable_gpe
> [12786.836242] acpi_ev_notify_dispatch
> [12786.957678] acpi_ev_asynch_execute_gpe_method
> [12786.958065] acpi_ev_notify_dispatch
> [12786.964196] acpi_ev_asynch_enable_gpe
> [12786.964205] acpi_ev_notify_dispatch
> [12786.964244] acpi_ev_asynch_execute_gpe_method
> [12786.970213] acpi_ev_notify_dispatch
> [12786.971816] acpi_ev_asynch_enable_gpe
> [12786.971825] acpi_ev_notify_dispatch
> [12786.997100] acpi_ev_asynch_execute_gpe_method
> [12786.997472] acpi_ev_notify_dispatch
> [12787.003279] acpi_ev_asynch_enable_gpe
> [12787.003290] acpi_ev_notify_dispatch
> [12787.003317] acpi_ev_asynch_execute_gpe_method
> [12787.008331] acpi_ev_notify_dispatch
> [12787.010682] acpi_ev_asynch_enable_gpe
> [12787.010692] acpi_ev_notify_dispatch
> [12787.309017] acpi_ev_asynch_execute_gpe_method
> [12787.313035] acpi_ev_notify_dispatch
> [12787.315300] acpi_ev_asynch_enable_gpe
> [12787.319026] acpi_ev_asynch_execute_gpe_method
> [12787.319387] acpi_ev_notify_dispatch
> [12787.326065] acpi_ev_asynch_enable_gpe
> [12787.326075] acpi_ev_notify_dispatch
> [12787.326113] acpi_ev_asynch_execute_gpe_method
> [12787.332078] acpi_ev_notify_dispatch
> [12787.333685] acpi_ev_asynch_enable_gpe
> [12787.333694] acpi_ev_notify_dispatch
> [12788.338728] acpi_ev_asynch_execute_gpe_method
> [12788.339140] acpi_ev_notify_dispatch
> [12788.345606] acpi_ev_asynch_enable_gpe
> [12788.345616] acpi_ev_notify_dispatch
> [12788.345660] acpi_ev_asynch_execute_gpe_method
> [12788.350599] acpi_ev_notify_dispatch
> [12788.352955] acpi_ev_asynch_enable_gpe
> [12788.352965] acpi_ev_notify_dispatch
> [12789.646199] acpi_ev_asynch_execute_gpe_method
> [12789.646595] acpi_ev_notify_dispatch
> [12789.652861] acpi_ev_asynch_enable_gpe
> [12789.652871] acpi_ev_notify_dispatch
> [12789.652913] acpi_ev_asynch_execute_gpe_method
> [12789.658870] acpi_ev_notify_dispatch
> [12789.660495] acpi_ev_asynch_enable_gpe
> [12789.660505] acpi_ev_notify_dispatch
> [12791.535774] acpi_ev_asynch_execute_gpe_method
> [12791.536210] acpi_ev_notify_dispatch
> [12791.542525] acpi_ev_asynch_enable_gpe
> [12791.542535] acpi_ev_notify_dispatch
> [12791.542580] acpi_ev_asynch_execute_gpe_method
> [12791.547545] acpi_ev_notify_dispatch
> [12791.549935] acpi_ev_asynch_enable_gpe
> [12791.549944] acpi_ev_notify_dispatch
> [12791.593592] acpi_ev_asynch_execute_gpe_method
> [12791.593976] acpi_ev_notify_dispatch
> [12791.599677] acpi_ev_asynch_enable_gpe
> [12791.599686] acpi_ev_notify_dispatch
> [12791.599730] acpi_ev_asynch_execute_gpe_method
> [12791.604667] acpi_ev_notify_dispatch
> [12791.607042] acpi_ev_asynch_enable_gpe
> [12791.607052] acpi_ev_notify_dispatch
> [12791.672433] acpi_ev_asynch_execute_gpe_method
> [12791.672801] acpi_ev_notify_dispatch
> [12791.678850] acpi_ev_asynch_enable_gpe
> [12791.678859] acpi_ev_notify_dispatch
> [12791.678902] acpi_ev_asynch_execute_gpe_method
> [12791.683884] acpi_ev_notify_dispatch
> [12791.686249] acpi_ev_asynch_enable_gpe
> [12791.686259] acpi_ev_notify_dispatch
> [12791.689514] acpi_ev_asynch_execute_gpe_method
> [12791.689868] acpi_ev_notify_dispatch
> [12791.696055] acpi_ev_asynch_enable_gpe
> [12791.696064] acpi_ev_notify_dispatch
> [12791.696103] acpi_ev_asynch_execute_gpe_method
> [12791.701927] acpi_ev_notify_dispatch
> [12791.703545] acpi_ev_asynch_enable_gpe
> [12791.703554] acpi_ev_notify_dispatch
> [12791.705273] acpi_ev_asynch_execute_gpe_method
> [12791.705698] acpi_ev_notify_dispatch
> [12791.711953] acpi_ev_asynch_enable_gpe
> [12791.711962] acpi_ev_notify_dispatch
> [12791.712031] acpi_ev_asynch_execute_gpe_method
> [12791.716945] acpi_ev_notify_dispatch
> [12791.719313] acpi_ev_asynch_enable_gpe
> [12791.719322] acpi_ev_notify_dispatch
> =3D=3D=3D dmesg =3D=3D=3D=3D
>=20
> Is there something I can do to trace the problem? dmesg and lspci
> are attached.
>=20
> Thanks,
> Ali
Hi Ali,

Please open new bug at bugzilla.kernel.org, for ACPI.=20
It would help if you provide name of your machine (make?) and acpidump =
output.
Do you know the kernel, there this problem did not occur (is it a regre=
ssion)?
Let's continue problem discussion in bugzilla.

Regards,
Alex.
