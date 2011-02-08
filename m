From: Corentin Chary <corentin.chary@gmail.com>
Subject: What's part of the ABI (breaking eeepc-wmi)
Date: Tue, 8 Feb 2011 08:51:27 +0000
Message-ID: <AANLkTim5kG-pZRpj+6ckOvuk5ZSJ_O7zbwBnC4JNQPtS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46344 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379Ab1BHIv3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Feb 2011 03:51:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: linux acpi <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,
I recently discovered that new Asus notebooks (eg: not Eeepc) are now
shipped with an ACPI WMI device instead of the old ACPI Atkd device.
Most of this device is similar to the Eeepc ACPI WMI device, except
for keymap and event GUID.

I could add support for these notebooks in eeepc-wmi, but that seems
really weird.

A first solution is to rename eeepc-wmi asus-wmi, and create an alias
to make eeepc-wmi work. Then this driver would handle asus-wmi and
eeepc-wmi platform drivers (it could also be splitted in 3
files/modules, common/notebook/eeepc).
But then, is it important to keep these strings ?
- hotplug string ("eeepc-wifi")
- rfkill names ("eeepc-xxxxx")
- led names ("eeepc::xxxxxx")
- input strings (.phys and .name)

If these strings should really be keeped for backward compatibility, I
was thinking of something like that:

----
struct module;
struct key_entry;

static struct asus_wmi_driver {
  const char                    *name;
  struct module                 *owner;

  const struct key_entry        *keymap;

  int (*probe) (struct asus_wmi *asus);
  int (*quirks) (struct asus_wmi *asus);

  struct {
    const char                  *input_name;
    const char                  *input_phys;
    const char                  *led_touchpad;
    const char                  *hotplug_wlan;
    const char                  *rfkill_wlan;
    const char                  *rfkill_bluetooth;
    const char                  *rfkill_wimax;
    const char                  *rfkill_wwan3g;
  } strings;

  struct asus_wmi *device;
};

int asus_wmi_register_driver(struct asus_wmi_driver *driver);
void asus_wmi_unregister_driver(struct asus_wmi_driver *driver);
----

Any thoughts on that ?

-- 
Corentin Chary
http://xf.iksaif.net
