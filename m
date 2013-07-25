From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: Linux 3.11-rc2 (acpi backlight, revert)
Date: Thu, 25 Jul 2013 22:13:26 +0800
Message-ID: <CAOzJMDRp4OLphsdG0jmtLNuBEH__QgGn2+_iY2aZP-gisf0c3w@mail.gmail.com>
References: <CA+55aFy330bSRjK5HT1n0wXioPykL3RquHXyBPjm5GpTz_Y=DQ@mail.gmail.com>
	<CA+55aFyrMRDD8qe9DYXixaSLJXEURMYYku1azABA72m71_X+cA@mail.gmail.com>
	<9012759.Alzqtdvh5b@vostro.rjw.lan>
	<2218913.HKGjJcYT1G@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1535029634=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <2218913.HKGjJcYT1G@vostro.rjw.lan>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, James Hogan <james@albanarts.com>, Martin Steigerwald <Martin@lichtvoll.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, =?ISO-8859-1?Q?J=F6rg_Otte?= <jrg.otte@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, Linus Torvalds <torvalds@linux-foundation.org>, Kalle Valo <kvalo@adurom.com>
List-Id: linux-acpi@vger.kernel.org

--===============1535029634==
Content-Type: multipart/alternative; boundary=047d7ba97b943a1f6f04e256a112

--047d7ba97b943a1f6f04e256a112
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2013 at 9:00 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Monday, July 22, 2013 09:54:21 PM Rafael J. Wysocki wrote:
> > On Monday, July 22, 2013 11:11:54 AM Linus Torvalds wrote:
> > > On Mon, Jul 22, 2013 at 6:02 AM, Rafael J. Wysocki <rjw@sisk.pl>
> wrote:
> > > >
> > > > Linus, do you want me to send a pull request reverting 8c5bd7a and
> efaa14c?
> > >
> > > Yes, but let's wait a while. Not because I think we'll fix the proble=
m
> > > (hey, miracles might happen), but because I think it would be useful
> > > to couple the reverts with information about the particular machines
> > > that broke (and the people who reported it). So that when we
> > > inevitably try again, we can perhaps get some testing effort with
> > > those machines/people.
> > >
> > > It doesn't seem to be a show-stopped for a large number of people, so
> > > there's no huge hurry. I'd suggest doing the revert just in time for
> > > rc3, but waiting until then to gather info about people who see
> > > breakage.
> > >
> > > Sound like a plan?
> >
> > Yes, it does.
>
> OK, time to revert I guess.
>
> James, Kamal, Steven, J=F6rg, Martin, Kalle, please check if the apppende=
d
> patch
> fixes the backlight for you.
>
> Aaron, please double check if acpi_video_backlight_quirks() will still
> work as
> needed.
>

Yes, I think so.

Thanks,
Aaron


>
> Thanks,
> Rafael
>
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: Revert "ACPI / video / i915: No ACPI backlight if firmware
> expects Windows 8"
>
> We attempted to address a regression introduced by commit a57f7f9
> (ACPICA: Add Windows8/Server2012 string for _OSI method.) after which
> ACPI video backlight support doesn't work on a number of systems,
> because the relevant AML methods in the ACPI tables in their BIOSes
> become useless after the BIOS has been told that the OS is compatible
> with Windows 8.  That problem is tracked by the bug entry at:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D51231
>
> Commit 8c5bd7a (ACPI / video / i915: No ACPI backlight if firmware
> expects Windows 8) introduced for this purpose essentially prevented
> the ACPI backlight support from being used if the BIOS had been told
> that the OS was compatible with Windows 8 and the i915 driver was
> loaded, in which case the backlight would always be handled by i915.
> Unfortunately, however, that turned out to cause problems with
> backlight to appear on multiple systems with symptoms indicating that
> i915 was unable to control the backlight on those systems as
> expected.
>
> For this reason, revert commit 8c5bd7a, but leave the function
> acpi_video_backlight_quirks() introduced by it, because another
> commit on top of it uses that function.
>
> References: https://lkml.org/lkml/2013/7/21/119
> References: https://lkml.org/lkml/2013/7/22/261
> References: https://lkml.org/lkml/2013/7/23/429
> References: https://lkml.org/lkml/2013/7/23/459
> References: https://lkml.org/lkml/2013/7/23/81
> References: https://lkml.org/lkml/2013/7/24/27
> Reported-by: James Hogan <james@albanarts.com>
> Reported-by: Steven Newbury <steve@snewbury.org.uk>
> Reported-by: Kamal Mostafa <kamal@canonical.com>
> Reported-by: Martin Steigerwald <Martin@lichtvoll.de>
> Reported-by: J=F6rg Otte <jrg.otte@gmail.com>
> Reported-by: Kalle Valo <kvalo@adurom.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/internal.h         |    2 -
>  drivers/acpi/video.c            |   67
> ++++------------------------------------
>  drivers/acpi/video_detect.c     |   15 --------
>  drivers/gpu/drm/i915/i915_dma.c |    2 -
>  include/acpi/video.h            |   11 ------
>  include/linux/acpi.h            |    1
>  6 files changed, 11 insertions(+), 87 deletions(-)
>
> Index: linux-pm/drivers/acpi/video.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/video.c
> +++ linux-pm/drivers/acpi/video.c
> @@ -897,7 +897,7 @@ static void acpi_video_device_find_cap(s
>         if (acpi_video_init_brightness(device))
>                 return;
>
> -       if (acpi_video_verify_backlight_support()) {
> +       if (acpi_video_backlight_support()) {
>                 struct backlight_properties props;
>                 struct pci_dev *pdev;
>                 acpi_handle acpi_parent;
> @@ -1344,8 +1344,8 @@ acpi_video_switch_brightness(struct acpi
>         unsigned long long level_current, level_next;
>         int result =3D -EINVAL;
>
> -       /* no warning message if acpi_backlight=3Dvendor or a quirk is us=
ed
> */
> -       if (!acpi_video_verify_backlight_support())
> +       /* no warning message if acpi_backlight=3Dvendor is used */
> +       if (!acpi_video_backlight_support())
>                 return 0;
>
>         if (!device->brightness)
> @@ -1843,46 +1843,6 @@ static int acpi_video_bus_remove(struct
>         return 0;
>  }
>
> -static acpi_status video_unregister_backlight(acpi_handle handle, u32 lv=
l,
> -                                             void *context, void **rv)
> -{
> -       struct acpi_device *acpi_dev;
> -       struct acpi_video_bus *video;
> -       struct acpi_video_device *dev, *next;
> -
> -       if (acpi_bus_get_device(handle, &acpi_dev))
> -               return AE_OK;
> -
> -       if (acpi_match_device_ids(acpi_dev, video_device_ids))
> -               return AE_OK;
> -
> -       video =3D acpi_driver_data(acpi_dev);
> -       if (!video)
> -               return AE_OK;
> -
> -       acpi_video_bus_stop_devices(video);
> -       mutex_lock(&video->device_list_lock);
> -       list_for_each_entry_safe(dev, next, &video->video_device_list,
> entry) {
> -               if (dev->backlight) {
> -                       backlight_device_unregister(dev->backlight);
> -                       dev->backlight =3D NULL;
> -                       kfree(dev->brightness->levels);
> -                       kfree(dev->brightness);
> -               }
> -               if (dev->cooling_dev) {
> -                       sysfs_remove_link(&dev->dev->dev.kobj,
> -                                         "thermal_cooling");
> -                       sysfs_remove_link(&dev->cooling_dev->device.kobj,
> -                                         "device");
> -
> thermal_cooling_device_unregister(dev->cooling_dev);
> -                       dev->cooling_dev =3D NULL;
> -               }
> -       }
> -       mutex_unlock(&video->device_list_lock);
> -       acpi_video_bus_start_devices(video);
> -       return AE_OK;
> -}
> -
>  static int __init is_i740(struct pci_dev *dev)
>  {
>         if (dev->device =3D=3D 0x00D1)
> @@ -1914,25 +1874,14 @@ static int __init intel_opregion_present
>         return opregion;
>  }
>
> -int __acpi_video_register(bool backlight_quirks)
> +int acpi_video_register(void)
>  {
> -       bool no_backlight;
> -       int result;
> -
> -       no_backlight =3D backlight_quirks ? acpi_video_backlight_quirks()=
 :
> false;
> -
> +       int result =3D 0;
>         if (register_count) {
>                 /*
> -                * If acpi_video_register() has been called already, don'=
t
> try
> -                * to register acpi_video_bus, but unregister backlight
> devices
> -                * if no backlight support is requested.
> +                * if the function of acpi_video_register is already
> called,
> +                * don't register the acpi_vide_bus again and return no
> error.
>                  */
> -               if (no_backlight)
> -                       acpi_walk_namespace(ACPI_TYPE_DEVICE,
> ACPI_ROOT_OBJECT,
> -                                           ACPI_UINT32_MAX,
> -                                           video_unregister_backlight,
> -                                           NULL, NULL, NULL);
> -
>                 return 0;
>         }
>
> @@ -1948,7 +1897,7 @@ int __acpi_video_register(bool backlight
>
>         return 0;
>  }
> -EXPORT_SYMBOL(__acpi_video_register);
> +EXPORT_SYMBOL(acpi_video_register);
>
>  void acpi_video_unregister(void)
>  {
> Index: linux-pm/drivers/gpu/drm/i915/i915_dma.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/gpu/drm/i915/i915_dma.c
> +++ linux-pm/drivers/gpu/drm/i915/i915_dma.c
> @@ -1648,7 +1648,7 @@ int i915_driver_load(struct drm_device *
>         if (INTEL_INFO(dev)->num_pipes) {
>                 /* Must be done after probing outputs */
>                 intel_opregion_init(dev);
> -               acpi_video_register_with_quirks();
> +               acpi_video_register();
>         }
>
>         if (IS_GEN5(dev))
> Index: linux-pm/include/acpi/video.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/acpi/video.h
> +++ linux-pm/include/acpi/video.h
> @@ -17,21 +17,12 @@ struct acpi_device;
>  #define ACPI_VIDEO_DISPLAY_LEGACY_TV      0x0200
>
>  #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
> -extern int __acpi_video_register(bool backlight_quirks);
> -static inline int acpi_video_register(void)
> -{
> -       return __acpi_video_register(false);
> -}
> -static inline int acpi_video_register_with_quirks(void)
> -{
> -       return __acpi_video_register(true);
> -}
> +extern int acpi_video_register(void);
>  extern void acpi_video_unregister(void);
>  extern int acpi_video_get_edid(struct acpi_device *device, int type,
>                                int device_id, void **edid);
>  #else
>  static inline int acpi_video_register(void) { return 0; }
> -static inline int acpi_video_register_with_quirks(void) { return 0; }
>  static inline void acpi_video_unregister(void) { return; }
>  static inline int acpi_video_get_edid(struct acpi_device *device, int
> type,
>                                       int device_id, void **edid)
> Index: linux-pm/drivers/acpi/video_detect.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/video_detect.c
> +++ linux-pm/drivers/acpi/video_detect.c
> @@ -235,12 +235,7 @@ static void acpi_video_caps_check(void)
>
>  bool acpi_video_backlight_quirks(void)
>  {
> -       if (acpi_gbl_osi_data >=3D ACPI_OSI_WIN_8) {
> -               acpi_video_caps_check();
> -               acpi_video_support |=3D ACPI_VIDEO_SKIP_BACKLIGHT;
> -               return true;
> -       }
> -       return false;
> +       return acpi_gbl_osi_data >=3D ACPI_OSI_WIN_8;
>  }
>  EXPORT_SYMBOL(acpi_video_backlight_quirks);
>
> @@ -288,14 +283,6 @@ int acpi_video_backlight_support(void)
>  }
>  EXPORT_SYMBOL(acpi_video_backlight_support);
>
> -/* For the ACPI video driver use only. */
> -bool acpi_video_verify_backlight_support(void)
> -{
> -       return (acpi_video_support & ACPI_VIDEO_SKIP_BACKLIGHT) ?
> -               false : acpi_video_backlight_support();
> -}
> -EXPORT_SYMBOL(acpi_video_verify_backlight_support);
> -
>  /*
>   * Use acpi_backlight=3Dvendor/video to force that backlight switching
>   * is processed by vendor specific acpi drivers or video.ko driver.
> Index: linux-pm/include/linux/acpi.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -191,7 +191,6 @@ extern bool wmi_has_guid(const char *gui
>  #define ACPI_VIDEO_BACKLIGHT_DMI_VIDEO                 0x0200
>  #define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR         0x0400
>  #define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VIDEO          0x0800
> -#define ACPI_VIDEO_SKIP_BACKLIGHT                      0x1000
>
>  #if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
>
> Index: linux-pm/drivers/acpi/internal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -169,10 +169,8 @@ int acpi_create_platform_device(struct a
>
>  ------------------------------------------------------------------------=
--
> */
>  #if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)
>  bool acpi_video_backlight_quirks(void);
> -bool acpi_video_verify_backlight_support(void);
>  #else
>  static inline bool acpi_video_backlight_quirks(void) { return false; }
> -static inline bool acpi_video_verify_backlight_support(void) { return
> false; }
>  #endif
>
>  #endif /* _ACPI_INTERNAL_H_ */
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7ba97b943a1f6f04e256a112
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Thu, Jul 25, 2013 at 9:00 PM, Rafael J. Wysocki <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:rjw@sisk.pl" target=3D"_blank">rjw@sisk.pl=
</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">
On Monday, July 22, 2013 09:54:21 PM Rafael J. Wysocki wrote:<br>
&gt; On Monday, July 22, 2013 11:11:54 AM Linus Torvalds wrote:<br>
&gt; &gt; On Mon, Jul 22, 2013 at 6:02 AM, Rafael J. Wysocki &lt;<a href=3D=
"mailto:rjw@sisk.pl">rjw@sisk.pl</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Linus, do you want me to send a pull request reverting 8c5bd=
7a and efaa14c?<br>
&gt; &gt;<br>
&gt; &gt; Yes, but let&#39;s wait a while. Not because I think we&#39;ll fi=
x the problem<br>
&gt; &gt; (hey, miracles might happen), but because I think it would be use=
ful<br>
&gt; &gt; to couple the reverts with information about the particular machi=
nes<br>
&gt; &gt; that broke (and the people who reported it). So that when we<br>
&gt; &gt; inevitably try again, we can perhaps get some testing effort with=
<br>
&gt; &gt; those machines/people.<br>
&gt; &gt;<br>
&gt; &gt; It doesn&#39;t seem to be a show-stopped for a large number of pe=
ople, so<br>
&gt; &gt; there&#39;s no huge hurry. I&#39;d suggest doing the revert just =
in time for<br>
&gt; &gt; rc3, but waiting until then to gather info about people who see<b=
r>
&gt; &gt; breakage.<br>
&gt; &gt;<br>
&gt; &gt; Sound like a plan?<br>
&gt;<br>
&gt; Yes, it does.<br>
<br>
OK, time to revert I guess.<br>
<br>
James, Kamal, Steven, J=F6rg, Martin, Kalle, please check if the apppended =
patch<br>
fixes the backlight for you.<br>
<br>
Aaron, please double check if acpi_video_backlight_quirks() will still work=
 as<br>
needed.<br></blockquote><div><br></div><div>Yes, I think so.</div><div><br>=
</div><div>Thanks,</div><div>Aaron</div><div>=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">

<br>
Thanks,<br>
Rafael<br>
<br>
<br>
---<br>
From: Rafael J. Wysocki &lt;<a href=3D"mailto:rafael.j.wysocki@intel.com">r=
afael.j.wysocki@intel.com</a>&gt;<br>
Subject: Revert &quot;ACPI / video / i915: No ACPI backlight if firmware ex=
pects Windows 8&quot;<br>
<br>
We attempted to address a regression introduced by commit a57f7f9<br>
(ACPICA: Add Windows8/Server2012 string for _OSI method.) after which<br>
ACPI video backlight support doesn&#39;t work on a number of systems,<br>
because the relevant AML methods in the ACPI tables in their BIOSes<br>
become useless after the BIOS has been told that the OS is compatible<br>
with Windows 8. =A0That problem is tracked by the bug entry at:<br>
<br>
<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D51231" target=3D"_=
blank">https://bugzilla.kernel.org/show_bug.cgi?id=3D51231</a><br>
<br>
Commit 8c5bd7a (ACPI / video / i915: No ACPI backlight if firmware<br>
expects Windows 8) introduced for this purpose essentially prevented<br>
the ACPI backlight support from being used if the BIOS had been told<br>
that the OS was compatible with Windows 8 and the i915 driver was<br>
loaded, in which case the backlight would always be handled by i915.<br>
Unfortunately, however, that turned out to cause problems with<br>
backlight to appear on multiple systems with symptoms indicating that<br>
i915 was unable to control the backlight on those systems as<br>
expected.<br>
<br>
For this reason, revert commit 8c5bd7a, but leave the function<br>
acpi_video_backlight_quirks() introduced by it, because another<br>
commit on top of it uses that function.<br>
<br>
References: <a href=3D"https://lkml.org/lkml/2013/7/21/119" target=3D"_blan=
k">https://lkml.org/lkml/2013/7/21/119</a><br>
References: <a href=3D"https://lkml.org/lkml/2013/7/22/261" target=3D"_blan=
k">https://lkml.org/lkml/2013/7/22/261</a><br>
References: <a href=3D"https://lkml.org/lkml/2013/7/23/429" target=3D"_blan=
k">https://lkml.org/lkml/2013/7/23/429</a><br>
References: <a href=3D"https://lkml.org/lkml/2013/7/23/459" target=3D"_blan=
k">https://lkml.org/lkml/2013/7/23/459</a><br>
References: <a href=3D"https://lkml.org/lkml/2013/7/23/81" target=3D"_blank=
">https://lkml.org/lkml/2013/7/23/81</a><br>
References: <a href=3D"https://lkml.org/lkml/2013/7/24/27
Reported-by" target=3D"_blank">https://lkml.org/lkml/2013/7/24/27<br>
Reported-by</a>: James Hogan &lt;<a href=3D"mailto:james@albanarts.com">jam=
es@albanarts.com</a>&gt;<br>
Reported-by: Steven Newbury &lt;<a href=3D"mailto:steve@snewbury.org.uk">st=
eve@snewbury.org.uk</a>&gt;<br>
Reported-by: Kamal Mostafa &lt;<a href=3D"mailto:kamal@canonical.com">kamal=
@canonical.com</a>&gt;<br>
Reported-by: Martin Steigerwald &lt;<a href=3D"mailto:Martin@lichtvoll.de">=
Martin@lichtvoll.de</a>&gt;<br>
Reported-by: J=F6rg Otte &lt;<a href=3D"mailto:jrg.otte@gmail.com">jrg.otte=
@gmail.com</a>&gt;<br>
Reported-by: Kalle Valo &lt;<a href=3D"mailto:kvalo@adurom.com">kvalo@aduro=
m.com</a>&gt;<br>
Signed-off-by: Rafael J. Wysocki &lt;<a href=3D"mailto:rafael.j.wysocki@int=
el.com">rafael.j.wysocki@intel.com</a>&gt;<br>
---<br>
=A0drivers/acpi/internal.h =A0 =A0 =A0 =A0 | =A0 =A02 -<br>
=A0drivers/acpi/video.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 67 ++++---------------=
---------------------<br>
=A0drivers/acpi/video_detect.c =A0 =A0 | =A0 15 --------<br>
=A0drivers/gpu/drm/i915/i915_dma.c | =A0 =A02 -<br>
=A0include/acpi/video.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 ------<br>
=A0include/linux/acpi.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01<br>
=A06 files changed, 11 insertions(+), 87 deletions(-)<br>
<br>
Index: linux-pm/drivers/acpi/video.c<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-pm.orig/drivers/acpi/video.c<br>
+++ linux-pm/drivers/acpi/video.c<br>
@@ -897,7 +897,7 @@ static void acpi_video_device_find_cap(s<br>
=A0 =A0 =A0 =A0 if (acpi_video_init_brightness(device))<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
<br>
- =A0 =A0 =A0 if (acpi_video_verify_backlight_support()) {<br>
+ =A0 =A0 =A0 if (acpi_video_backlight_support()) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct backlight_properties props;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_dev *pdev;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_handle acpi_parent;<br>
@@ -1344,8 +1344,8 @@ acpi_video_switch_brightness(struct acpi<br>
=A0 =A0 =A0 =A0 unsigned long long level_current, level_next;<br>
=A0 =A0 =A0 =A0 int result =3D -EINVAL;<br>
<br>
- =A0 =A0 =A0 /* no warning message if acpi_backlight=3Dvendor or a quirk i=
s used */<br>
- =A0 =A0 =A0 if (!acpi_video_verify_backlight_support())<br>
+ =A0 =A0 =A0 /* no warning message if acpi_backlight=3Dvendor is used */<b=
r>
+ =A0 =A0 =A0 if (!acpi_video_backlight_support())<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
<br>
=A0 =A0 =A0 =A0 if (!device-&gt;brightness)<br>
@@ -1843,46 +1843,6 @@ static int acpi_video_bus_remove(struct<br>
=A0 =A0 =A0 =A0 return 0;<br>
=A0}<br>
<br>
-static acpi_status video_unregister_backlight(acpi_handle handle, u32 lvl,=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 void *context, void **rv)<br>
-{<br>
- =A0 =A0 =A0 struct acpi_device *acpi_dev;<br>
- =A0 =A0 =A0 struct acpi_video_bus *video;<br>
- =A0 =A0 =A0 struct acpi_video_device *dev, *next;<br>
-<br>
- =A0 =A0 =A0 if (acpi_bus_get_device(handle, &amp;acpi_dev))<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK;<br>
-<br>
- =A0 =A0 =A0 if (acpi_match_device_ids(acpi_dev, video_device_ids))<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK;<br>
-<br>
- =A0 =A0 =A0 video =3D acpi_driver_data(acpi_dev);<br>
- =A0 =A0 =A0 if (!video)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK;<br>
-<br>
- =A0 =A0 =A0 acpi_video_bus_stop_devices(video);<br>
- =A0 =A0 =A0 mutex_lock(&amp;video-&gt;device_list_lock);<br>
- =A0 =A0 =A0 list_for_each_entry_safe(dev, next, &amp;video-&gt;video_devi=
ce_list, entry) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev-&gt;backlight) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 backlight_device_unregister(d=
ev-&gt;backlight);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;backlight =3D NULL;<b=
r>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dev-&gt;brightness-&gt;=
levels);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dev-&gt;brightness);<br=
>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev-&gt;cooling_dev) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysfs_remove_link(&amp;dev-&g=
t;dev-&gt;dev.kobj,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &quot;thermal_cooling&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysfs_remove_link(&amp;dev-&g=
t;cooling_dev-&gt;device.kobj,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &quot;device&quot;);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 thermal_cooling_device_unregi=
ster(dev-&gt;cooling_dev);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;cooling_dev =3D NULL;=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 mutex_unlock(&amp;video-&gt;device_list_lock);<br>
- =A0 =A0 =A0 acpi_video_bus_start_devices(video);<br>
- =A0 =A0 =A0 return AE_OK;<br>
-}<br>
-<br>
=A0static int __init is_i740(struct pci_dev *dev)<br>
=A0{<br>
=A0 =A0 =A0 =A0 if (dev-&gt;device =3D=3D 0x00D1)<br>
@@ -1914,25 +1874,14 @@ static int __init intel_opregion_present<br>
=A0 =A0 =A0 =A0 return opregion;<br>
=A0}<br>
<br>
-int __acpi_video_register(bool backlight_quirks)<br>
+int acpi_video_register(void)<br>
=A0{<br>
- =A0 =A0 =A0 bool no_backlight;<br>
- =A0 =A0 =A0 int result;<br>
-<br>
- =A0 =A0 =A0 no_backlight =3D backlight_quirks ? acpi_video_backlight_quir=
ks() : false;<br>
-<br>
+ =A0 =A0 =A0 int result =3D 0;<br>
=A0 =A0 =A0 =A0 if (register_count) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If acpi_video_register() has been called=
 already, don&#39;t try<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to register acpi_video_bus, but unregist=
er backlight devices<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if no backlight support is requested.<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* if the function of acpi_video_register i=
s already called,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* don&#39;t register the acpi_vide_bus aga=
in and return no error.<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (no_backlight)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_walk_namespace(ACPI_TYPE=
_DEVICE, ACPI_ROOT_OBJECT,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 ACPI_UINT32_MAX,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 video_unregister_backlight,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 NULL, NULL, NULL);<br>
-<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
@@ -1948,7 +1897,7 @@ int __acpi_video_register(bool backlight<br>
<br>
=A0 =A0 =A0 =A0 return 0;<br>
=A0}<br>
-EXPORT_SYMBOL(__acpi_video_register);<br>
+EXPORT_SYMBOL(acpi_video_register);<br>
<br>
=A0void acpi_video_unregister(void)<br>
=A0{<br>
Index: linux-pm/drivers/gpu/drm/i915/i915_dma.c<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-pm.orig/drivers/gpu/drm/i915/i915_dma.c<br>
+++ linux-pm/drivers/gpu/drm/i915/i915_dma.c<br>
@@ -1648,7 +1648,7 @@ int i915_driver_load(struct drm_device *<br>
=A0 =A0 =A0 =A0 if (INTEL_INFO(dev)-&gt;num_pipes) {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Must be done after probing outputs */<br=
>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 intel_opregion_init(dev);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_video_register_with_quirks();<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_video_register();<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 if (IS_GEN5(dev))<br>
Index: linux-pm/include/acpi/video.h<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-pm.orig/include/acpi/video.h<br>
+++ linux-pm/include/acpi/video.h<br>
@@ -17,21 +17,12 @@ struct acpi_device;<br>
=A0#define ACPI_VIDEO_DISPLAY_LEGACY_TV =A0 =A0 =A00x0200<br>
<br>
=A0#if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)<br>
-extern int __acpi_video_register(bool backlight_quirks);<br>
-static inline int acpi_video_register(void)<br>
-{<br>
- =A0 =A0 =A0 return __acpi_video_register(false);<br>
-}<br>
-static inline int acpi_video_register_with_quirks(void)<br>
-{<br>
- =A0 =A0 =A0 return __acpi_video_register(true);<br>
-}<br>
+extern int acpi_video_register(void);<br>
=A0extern void acpi_video_unregister(void);<br>
=A0extern int acpi_video_get_edid(struct acpi_device *device, int type,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int device_i=
d, void **edid);<br>
=A0#else<br>
=A0static inline int acpi_video_register(void) { return 0; }<br>
-static inline int acpi_video_register_with_quirks(void) { return 0; }<br>
=A0static inline void acpi_video_unregister(void) { return; }<br>
=A0static inline int acpi_video_get_edid(struct acpi_device *device, int ty=
pe,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 int device_id, void **edid)<br>
Index: linux-pm/drivers/acpi/video_detect.c<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-pm.orig/drivers/acpi/video_detect.c<br>
+++ linux-pm/drivers/acpi/video_detect.c<br>
@@ -235,12 +235,7 @@ static void acpi_video_caps_check(void)<br>
<br>
=A0bool acpi_video_backlight_quirks(void)<br>
=A0{<br>
- =A0 =A0 =A0 if (acpi_gbl_osi_data &gt;=3D ACPI_OSI_WIN_8) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_video_caps_check();<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_video_support |=3D ACPI_VIDEO_SKIP_BACKL=
IGHT;<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;<br>
- =A0 =A0 =A0 }<br>
- =A0 =A0 =A0 return false;<br>
+ =A0 =A0 =A0 return acpi_gbl_osi_data &gt;=3D ACPI_OSI_WIN_8;<br>
=A0}<br>
=A0EXPORT_SYMBOL(acpi_video_backlight_quirks);<br>
<br>
@@ -288,14 +283,6 @@ int acpi_video_backlight_support(void)<br>
=A0}<br>
=A0EXPORT_SYMBOL(acpi_video_backlight_support);<br>
<br>
-/* For the ACPI video driver use only. */<br>
-bool acpi_video_verify_backlight_support(void)<br>
-{<br>
- =A0 =A0 =A0 return (acpi_video_support &amp; ACPI_VIDEO_SKIP_BACKLIGHT) ?=
<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 false : acpi_video_backlight_support();<br>
-}<br>
-EXPORT_SYMBOL(acpi_video_verify_backlight_support);<br>
-<br>
=A0/*<br>
=A0 * Use acpi_backlight=3Dvendor/video to force that backlight switching<b=
r>
=A0 * is processed by vendor specific acpi drivers or video.ko driver.<br>
Index: linux-pm/include/linux/acpi.h<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-pm.orig/include/linux/acpi.h<br>
+++ linux-pm/include/linux/acpi.h<br>
@@ -191,7 +191,6 @@ extern bool wmi_has_guid(const char *gui<br>
=A0#define ACPI_VIDEO_BACKLIGHT_DMI_VIDEO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0=
x0200<br>
=A0#define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VENDOR =A0 =A0 =A0 =A0 0x0400<br=
>
=A0#define ACPI_VIDEO_OUTPUT_SWITCHING_DMI_VIDEO =A0 =A0 =A0 =A0 =A00x0800<=
br>
-#define ACPI_VIDEO_SKIP_BACKLIGHT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x1000<br>
<br>
=A0#if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)<br>
<br>
Index: linux-pm/drivers/acpi/internal.h<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-pm.orig/drivers/acpi/internal.h<br>
+++ linux-pm/drivers/acpi/internal.h<br>
@@ -169,10 +169,8 @@ int acpi_create_platform_device(struct a<br>
=A0 =A0--------------------------------------------------------------------=
------ */<br>
=A0#if defined(CONFIG_ACPI_VIDEO) || defined(CONFIG_ACPI_VIDEO_MODULE)<br>
=A0bool acpi_video_backlight_quirks(void);<br>
-bool acpi_video_verify_backlight_support(void);<br>
=A0#else<br>
=A0static inline bool acpi_video_backlight_quirks(void) { return false; }<b=
r>
-static inline bool acpi_video_verify_backlight_support(void) { return fals=
e; }<br>
=A0#endif<br>
<br>
=A0#endif /* _ACPI_INTERNAL_H_ */<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-acpi&q=
uot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</blockquote></div><br></div></div>

--047d7ba97b943a1f6f04e256a112--

--===============1535029634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1535029634==--
