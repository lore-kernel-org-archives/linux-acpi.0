From: "Anton Gubar'kov" <anton.gubarkov@gmail.com>
Subject: Re: [PATCH] drm/i915/opregion: ignore firmware requests
	for backlight change
Date: Mon, 30 Jun 2014 09:26:13 +0400
Message-ID: <CAP=18J4FiGgUDwH=P1SfrYdOu-uYzFz6p1FT5Ai5C2QFB63Q1g@mail.gmail.com>
References: <53A8E400.5060709@intel.com> <87tx796yc5.fsf@intel.com>
 <53ACE2EF.8020808@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1410965255=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <53ACE2EF.8020808@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Aaron Lu <aaron.lu@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

--===============1410965255==
Content-Type: multipart/alternative; boundary=001a1136a5dccc2b7c04fd06e59d

--001a1136a5dccc2b7c04fd06e59d
Content-Type: text/plain; charset=UTF-8

Hi, I would like to inform that I use UEFI boot. I don't have a spare
machine/disk to test legacy unfortunately.

regards
Anton.


2014-06-27 7:20 GMT+04:00 Aaron Lu <aaron.lu@intel.com>:

> On 06/25/2014 07:08 PM, Jani Nikula wrote:
> > On Tue, 24 Jun 2014, Aaron Lu <aaron.lu@intel.com> wrote:
> >> Some Thinkpad laptops' firmware will initiate a backlight level change
> >> request through operation region on the events of AC plug/unplug, but
> >> since we are not using firmware's interface to do the backlight setting
> >> on these affected laptops, we do not want the firmware to use some
> >> arbitrary value from its ASL variable to set the backlight level on
> >> AC plug/unplug either.
> >
> > I'm curious whether this happens with EFI boot, or only with legacy.
>
> Igor, Anton,
>
> Are you using legacy boot or UEFI boot?
> Possible to test the other case?
>
> >
> > One comment inline, otherwise
>
> Will add that in next revision.
>
> >
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
>
> Thanks for the review!
>
> -Aaron
>
> >
> > for merging through the ACPI tree, as the change is more likely to
> > conflict there.
> >
> >> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=76491
> >> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=77091
> >> Reported-and-tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
> >> Reported-and-tested-by: Anton Gubarkov <anton.gubarkov@gmail.com>
> >> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> >> ---
> >>  drivers/acpi/video.c                  | 3 ++-
> >>  drivers/gpu/drm/i915/intel_opregion.c | 7 +++++++
> >>  include/acpi/video.h                  | 2 ++
> >>  3 files changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> >> index fb9ffe9adc64..cf99d6d2d491 100644
> >> --- a/drivers/acpi/video.c
> >> +++ b/drivers/acpi/video.c
> >> @@ -241,13 +241,14 @@ static bool acpi_video_use_native_backlight(void)
> >>              return use_native_backlight_dmi;
> >>  }
> >>
> >> -static bool acpi_video_verify_backlight_support(void)
> >> +bool acpi_video_verify_backlight_support(void)
> >>  {
> >>      if (acpi_osi_is_win8() && acpi_video_use_native_backlight() &&
> >>          backlight_device_registered(BACKLIGHT_RAW))
> >>              return false;
> >>      return acpi_video_backlight_support();
> >>  }
> >> +EXPORT_SYMBOL(acpi_video_verify_backlight_support);
> >>
> >>  /* backlight device sysfs support */
> >>  static int acpi_video_get_brightness(struct backlight_device *bd)
> >> diff --git a/drivers/gpu/drm/i915/intel_opregion.c
> b/drivers/gpu/drm/i915/intel_opregion.c
> >> index 2e2c71fcc9ed..02943d93e88e 100644
> >> --- a/drivers/gpu/drm/i915/intel_opregion.c
> >> +++ b/drivers/gpu/drm/i915/intel_opregion.c
> >> @@ -403,6 +403,13 @@ static u32 asle_set_backlight(struct drm_device
> *dev, u32 bclp)
> >>
> >>      DRM_DEBUG_DRIVER("bclp = 0x%08x\n", bclp);
> >>
> >> +    /*
> >> +     * If the acpi_video interface is not supposed to be used, don't
> >> +     * bother processing backlight level change requests from firmware.
> >> +     */
> >> +    if (!acpi_video_verify_backlight_support())
> >> +            return 0;
> >
> > I'd appreciate a DRM_DEBUG_KMS here about what happened. We're bound to
> > wonder about that staring at some dmesg later on!
> >
> >> +
> >>      if (!(bclp & ASLE_BCLP_VALID))
> >>              return ASLC_BACKLIGHT_FAILED;
> >>
> >> diff --git a/include/acpi/video.h b/include/acpi/video.h
> >> index ea4c7bbded4d..92f8c4bffefb 100644
> >> --- a/include/acpi/video.h
> >> +++ b/include/acpi/video.h
> >> @@ -22,6 +22,7 @@ extern void acpi_video_unregister(void);
> >>  extern void acpi_video_unregister_backlight(void);
> >>  extern int acpi_video_get_edid(struct acpi_device *device, int type,
> >>                             int device_id, void **edid);
> >> +extern bool acpi_video_verify_backlight_support(void);
> >>  #else
> >>  static inline int acpi_video_register(void) { return 0; }
> >>  static inline void acpi_video_unregister(void) { return; }
> >> @@ -31,6 +32,7 @@ static inline int acpi_video_get_edid(struct
> acpi_device *device, int type,
> >>  {
> >>      return -ENODEV;
> >>  }
> >> +static bool acpi_video_verify_backlight_support() { return false; }
> >>  #endif
> >>
> >>  #endif
> >> --
> >> 1.9.3
> >>
> >
>
>

--001a1136a5dccc2b7c04fd06e59d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, I would like to inform that I use UEFI boot. I don&#39=
;t have a spare machine/disk to test legacy unfortunately.<div><br></div><d=
iv>regards</div><div>Anton.</div></div><div class=3D"gmail_extra"><br><br><=
div class=3D"gmail_quote">
2014-06-27 7:20 GMT+04:00 Aaron Lu <span dir=3D"ltr">&lt;<a href=3D"mailto:=
aaron.lu@intel.com" target=3D"_blank">aaron.lu@intel.com</a>&gt;</span>:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<div class=3D"">On 06/25/2014 07:08 PM, Jani Nikula wrote:<br>
&gt; On Tue, 24 Jun 2014, Aaron Lu &lt;<a href=3D"mailto:aaron.lu@intel.com=
">aaron.lu@intel.com</a>&gt; wrote:<br>
&gt;&gt; Some Thinkpad laptops&#39; firmware will initiate a backlight leve=
l change<br>
&gt;&gt; request through operation region on the events of AC plug/unplug, =
but<br>
&gt;&gt; since we are not using firmware&#39;s interface to do the backligh=
t setting<br>
&gt;&gt; on these affected laptops, we do not want the firmware to use some=
<br>
&gt;&gt; arbitrary value from its ASL variable to set the backlight level o=
n<br>
&gt;&gt; AC plug/unplug either.<br>
&gt;<br>
&gt; I&#39;m curious whether this happens with EFI boot, or only with legac=
y.<br>
<br>
</div>Igor, Anton,<br>
<br>
Are you using legacy boot or UEFI boot?<br>
Possible to test the other case?<br>
<br>
&gt;<br>
&gt; One comment inline, otherwise<br>
<br>
Will add that in next revision.<br>
<br>
&gt;<br>
&gt; Acked-by: Jani Nikula &lt;<a href=3D"mailto:jani.nikula@intel.com">jan=
i.nikula@intel.com</a>&gt;<br>
<br>
Thanks for the review!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Aaron<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; for merging through the ACPI tree, as the change is more likely to<br>
&gt; conflict there.<br>
&gt;<br>
&gt;&gt; Buglink: <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D=
76491" target=3D"_blank">https://bugzilla.kernel.org/show_bug.cgi?id=3D7649=
1</a><br>
&gt;&gt; Buglink: <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D=
77091" target=3D"_blank">https://bugzilla.kernel.org/show_bug.cgi?id=3D7709=
1</a><br>
&gt;&gt; Reported-and-tested-by: Igor Gnatenko &lt;<a href=3D"mailto:i.gnat=
enko.brain@gmail.com">i.gnatenko.brain@gmail.com</a>&gt;<br>
&gt;&gt; Reported-and-tested-by: Anton Gubarkov &lt;<a href=3D"mailto:anton=
.gubarkov@gmail.com">anton.gubarkov@gmail.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Aaron Lu &lt;<a href=3D"mailto:aaron.lu@intel.com">=
aaron.lu@intel.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0drivers/acpi/video.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 3 ++-<br>
&gt;&gt; =C2=A0drivers/gpu/drm/i915/intel_opregion.c | 7 +++++++<br>
&gt;&gt; =C2=A0include/acpi/video.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
&gt;&gt; =C2=A03 files changed, 11 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c<br>
&gt;&gt; index fb9ffe9adc64..cf99d6d2d491 100644<br>
&gt;&gt; --- a/drivers/acpi/video.c<br>
&gt;&gt; +++ b/drivers/acpi/video.c<br>
&gt;&gt; @@ -241,13 +241,14 @@ static bool acpi_video_use_native_backlight(=
void)<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return use_native_=
backlight_dmi;<br>
&gt;&gt; =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; -static bool acpi_video_verify_backlight_support(void)<br>
&gt;&gt; +bool acpi_video_verify_backlight_support(void)<br>
&gt;&gt; =C2=A0{<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0if (acpi_osi_is_win8() &amp;&amp; acpi_video_u=
se_native_backlight() &amp;&amp;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backlight_device_registered(BACK=
LIGHT_RAW))<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0return acpi_video_backlight_support();<br>
&gt;&gt; =C2=A0}<br>
&gt;&gt; +EXPORT_SYMBOL(acpi_video_verify_backlight_support);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0/* backlight device sysfs support */<br>
&gt;&gt; =C2=A0static int acpi_video_get_brightness(struct backlight_device=
 *bd)<br>
&gt;&gt; diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/d=
rm/i915/intel_opregion.c<br>
&gt;&gt; index 2e2c71fcc9ed..02943d93e88e 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/i915/intel_opregion.c<br>
&gt;&gt; +++ b/drivers/gpu/drm/i915/intel_opregion.c<br>
&gt;&gt; @@ -403,6 +403,13 @@ static u32 asle_set_backlight(struct drm_devi=
ce *dev, u32 bclp)<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_DRIVER(&quot;bclp =3D 0x%08x\n&quot;=
, bclp);<br>
&gt;&gt;<br>
&gt;&gt; + =C2=A0 =C2=A0/*<br>
&gt;&gt; + =C2=A0 =C2=A0 * If the acpi_video interface is not supposed to b=
e used, don&#39;t<br>
&gt;&gt; + =C2=A0 =C2=A0 * bother processing backlight level change request=
s from firmware.<br>
&gt;&gt; + =C2=A0 =C2=A0 */<br>
&gt;&gt; + =C2=A0 =C2=A0if (!acpi_video_verify_backlight_support())<br>
&gt;&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;<br>
&gt; I&#39;d appreciate a DRM_DEBUG_KMS here about what happened. We&#39;re=
 bound to<br>
&gt; wonder about that staring at some dmesg later on!<br>
&gt;<br>
&gt;&gt; +<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0if (!(bclp &amp; ASLE_BCLP_VALID))<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ASLC_BACKLI=
GHT_FAILED;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/include/acpi/video.h b/include/acpi/video.h<br>
&gt;&gt; index ea4c7bbded4d..92f8c4bffefb 100644<br>
&gt;&gt; --- a/include/acpi/video.h<br>
&gt;&gt; +++ b/include/acpi/video.h<br>
&gt;&gt; @@ -22,6 +22,7 @@ extern void acpi_video_unregister(void);<br>
&gt;&gt; =C2=A0extern void acpi_video_unregister_backlight(void);<br>
&gt;&gt; =C2=A0extern int acpi_video_get_edid(struct acpi_device *device, i=
nt type,<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int device_id, void **edid);<br>
&gt;&gt; +extern bool acpi_video_verify_backlight_support(void);<br>
&gt;&gt; =C2=A0#else<br>
&gt;&gt; =C2=A0static inline int acpi_video_register(void) { return 0; }<br=
>
&gt;&gt; =C2=A0static inline void acpi_video_unregister(void) { return; }<b=
r>
&gt;&gt; @@ -31,6 +32,7 @@ static inline int acpi_video_get_edid(struct acp=
i_device *device, int type,<br>
&gt;&gt; =C2=A0{<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
&gt;&gt; =C2=A0}<br>
&gt;&gt; +static bool acpi_video_verify_backlight_support() { return false;=
 }<br>
&gt;&gt; =C2=A0#endif<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0#endif<br>
&gt;&gt; --<br>
&gt;&gt; 1.9.3<br>
&gt;&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div>

--001a1136a5dccc2b7c04fd06e59d--

--===============1410965255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1410965255==--
