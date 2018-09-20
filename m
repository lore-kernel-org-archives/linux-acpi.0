From: Sedat Dilek <sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: acpi/iwlwifi: thermal thermal_zone3: failed to read out thermal zone (-61)
Date: Thu, 20 Sep 2018 15:42:48 +0200
Message-ID: <CA+icZUXxcxZvyo7ge33E_1PSnjUs7Lq=BdcX2rbB6pYka1S=cA@mail.gmail.com>
Reply-To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Johannes Berg <johannes.berg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Emmanuel Grumbach <emmanuel.grumbach-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I am seeing this with Linux v4.18.y and v4.19-rc4.

Investigating thermal_zone3...

# cat /sys/devices/virtual/thermal/thermal_zone3/type
iwlwifi

I have the following iwlwifi device and firmware installed...

[   10.476589] iwlwifi 0000:04:00.0: loaded firmware version
36.e91976c0.0 op_mode iwlmvm
[   10.519441] iwlwifi 0000:04:00.0: Detected Intel(R) Dual Band
Wireless AC 8265, REV=0x230

What informations do you need and how can I help?

Thanks.

Regards,
- Sedat -
