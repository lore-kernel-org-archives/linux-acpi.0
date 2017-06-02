From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Fri, 2 Jun 2017 11:12:50 -0400
Message-ID: <CADnq5_P_H8ZZXnXOoUcxNOFece3BRyzhZh2Z3mkw53eA20KiMQ@mail.gmail.com>
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de> <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de> <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
 <20170531092145.ytc2d6shpukxziie@wunner.de> <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
 <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org> <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>
 <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33504 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750813AbdFBPMw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2017 11:12:52 -0400
Received: by mail-yw0-f173.google.com with SMTP id 63so21771329ywr.0
        for <linux-acpi@vger.kernel.org>; Fri, 02 Jun 2017 08:12:51 -0700 (PDT)
In-Reply-To: <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Lukas Wunner <lukas@wunner.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>

On Fri, Jun 2, 2017 at 3:35 AM, Florian Echtler <floe@butterbrot.org> wrote:
> On 01.06.2017 19:53, Alex Deucher wrote:
>> On Thu, Jun 1, 2017 at 4:27 AM, Florian Echtler <floe@butterbrot.org> wrote:
>>> On 31.05.2017 14:57, Alex Deucher wrote:
>>>> On Wed, May 31, 2017 at 5:21 AM, Lukas Wunner <lukas@wunner.de> wrote:
>>>
>>> Here's the (substantial) dmesg output, with drm.debug=0xf:
>>> http://floe.butterbrot.org/external/radeon/dmesg_after_suspend
>>>
>>> I haven't been able to find any references to link training, though.
>>
>> I need your dmesg from boot to confirm the display topology, but eDP
>> with r7xx asics was pretty rare.  I suspect your system just uses
>> LVDS; as such there is no link training involved.
>
> I've updated the trace with increased log_buf_len so nothing is truncated:
>
> http://floe.butterbrot.org/external/radeon/dmesg_after_suspend.txt
>
> (trace now contains a full boot including suspend and wakeup)
>
> However, what I'm seeing now does sound like the internal connection is indeed eDP:
>
> [  166.816162] [drm:drm_mode_setcrtc] [CRTC:34:crtc-0]
> [  166.816166] [drm:drm_mode_setcrtc] [CONNECTOR:40:eDP-1]
> [  166.816167] [drm:drm_crtc_helper_set_config]
> [  166.816169] [drm:drm_crtc_helper_set_config] [CRTC:34:crtc-0] [FB:54]
> #connectors=1 (x y) (0 0)
> [  166.816170] [drm:drm_crtc_helper_set_config] crtc has no fb, full mode set
> [  166.816172] [drm:drm_mode_object_reference] OBJ ID: 40 (4)
> [  166.816173] [drm:drm_crtc_helper_set_config] encoder changed, full mode switch
> [  166.816174] [drm:drm_crtc_helper_set_config] crtc changed, full mode switch
> [  166.816174] [drm:drm_crtc_helper_set_config] [CONNECTOR:40:eDP-1] to
> [CRTC:34:crtc-0]
> [  166.816175] [drm:drm_crtc_helper_set_config] attempting to set mode from
> userspace
> [  166.816177] [drm:drm_mode_debug_printmodeline] Modeline 65:"" 0 241500 2560
> 2608 2640 2720 1440 1443 1448 1481 0x0 0x9
> [  166.816180] [drm:radeon_encoder_set_active_device] setting active device to
> 00000002 from 00000002 00000002 for encoder 3
> [  166.816183] [drm:radeon_get_monitor_bpc] eDP-1: Display bpc=8, returned bpc=8
> [  166.816185] [drm:drm_detect_monitor_audio] Monitor has basic audio support
> [  166.816186] [drm:radeon_get_monitor_bpc] eDP-1: Display bpc=8, returned bpc=8
> [  166.816188] [drm:drm_detect_monitor_audio] Monitor has basic audio support
> [  166.816192] [drm:drm_crtc_helper_set_mode] [CRTC:34:crtc-0]
> [  166.816208] [drm:radeon_get_monitor_bpc] eDP-1: Display bpc=8, returned bpc=8
> [  166.816210] [drm:radeon_atom_encoder_dpms] encoder dpms 30 to mode 3, devices
> 00000008, active_devices 00000000
> [  166.816213] [drm:radeon_atom_encoder_dpms] encoder dpms 22 to mode 3, devices
> 00000010, active_devices 00000000
> [  166.816235] [drm:drm_detect_monitor_audio] Monitor has basic audio support
> [  166.816237] [drm:radeon_compute_pll_avivo] 360000 - 360000, pll dividers -
> fb: 80.0 ref: 2, post 3
> [  166.824475] done.

Yes it is eDP:

[    3.197364] [drm] Radeon Display Connectors
[    3.197365] [drm] Connector 0:
[    3.197365] [drm]   DP-1
[    3.197366] [drm]   HPD1
[    3.197367] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48
0x7e4c 0x7e4c
[    3.197367] [drm]   Encoders:
[    3.197368] [drm]     DFP1: INTERNAL_UNIPHY
[    3.197369] [drm] Connector 1:
[    3.197369] [drm]   eDP-1
[    3.197370] [drm]   HPD2
[    3.197371] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58
0x7e5c 0x7e5c
[    3.197371] [drm]   Encoders:
[    3.197372] [drm]     LCD1: INTERNAL_UNIPHY
[    3.197372] [drm] Connector 2:
[    3.197372] [drm]   VGA-1
[    3.197373] [drm]   DDC: 0x7f10 0x7f10 0x7f14 0x7f14 0x7f18 0x7f18
0x7f1c 0x7f1c
[    3.197374] [drm]   Encoders:
[    3.197374] [drm]     CRT2: INTERNAL_KLDSCP_DAC2


>
> ... and a bit later:
>
> [  166.853787] [drm:radeon_dp_link_train_cr] clock recovery at voltage 0
> pre-emphasis 0
> [  166.853788] [drm:drm_detect_monitor_audio] Monitor has basic audio support
> [  166.855953] [drm:radeon_dp_link_train_ce] channel eq at voltage 0 pre-emphasis 0
>

Yes, the link training appears to complete fine.  I guess it's
something to do with the proprietary mux or backlight controls.

Alex

> Best, Florian
> --
> SENT FROM MY DEC VT50 TERMINAL
>
