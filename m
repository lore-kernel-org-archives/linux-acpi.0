From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the
 old connections with references
Date: Wed, 17 Apr 2019 18:03:03 +0200
Message-ID: <cb7cf930-cf76-ef73-49de-222895b133ea@redhat.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
 <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
 <a91a1d75-f224-9c9d-873a-f80467d2fb0c@redhat.com>
 <20190417063918.GI1747@kuha.fi.intel.com>
 <76d9ab79-a1d0-f3cd-ba5d-2325740c72ff@redhat.com>
 <20190417093252.GO1747@kuha.fi.intel.com>
 <2fcb2e2c-c390-1b49-7228-197f23401271@redhat.com>
 <20190417104454.GQ1747@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C16F2A63C9CF340E7A34C72F"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417104454.GQ1747@kuha.fi.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------C16F2A63C9CF340E7A34C72F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17-04-19 12:44, Heikki Krogerus wrote:
> On Wed, Apr 17, 2019 at 12:15:18PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 17-04-19 11:32, Heikki Krogerus wrote:
>>> On Wed, Apr 17, 2019 at 11:19:28AM +0200, Hans de Goede wrote:
>>
>> <snip>
>>
>>>> That is not going to work since the (virtual) mux / orientation-switch
>>>> devices are only registered once the driver binds to the piusb30532 i2c
>>>> device, so when creating the nodes we only have the piusb30532 i2c device.
>>>
>>> It's not a problem, that's why we have the software nodes. The nodes
>>> can be created before the device entires. The node for pi3usb30532
>>> will just be the parent node for the new nodes we add for the mux and
>>> switch.
>>>
>>>> I've been thinking some more about this and an easy fix is to have separate
>>>> fwnode_match functions for typec_switch_match and typec_mux_match and have
>>>> them check that the dev_name ends in "-mux" resp. "-switch" that requires
>>>> only a very minimal change to "usb: typec: Registering real device entries for the muxes"
>>>> and then everything should be fine.
>>>
>>> I don't want to do anymore device name matching unless we have to, and
>>> here we don't have to. We can name the nodes for those virtual mux and
>>> switch, and then just do fwnode_find_named_child_node() in
>>> pi3usb30532.c for both of them.
>>
>> Thinking more about this, I have a feeling that this makes things needlessly
>> complicated, checking the dev_name *ends* in "-mux" resp. "-switch" should be
>> 100% reliable since we call:
>>
>>          dev_set_name(&sw->dev, "%s-switch", dev_name(parent));
>>          dev_set_name(&mux->dev, "%s-mux", dev_name(parent));
>>
>> When registering the switch / mux, so I believe doing name (suffix) comparison
>> here is fine and much simpler. Anyways this is just my 2 cents on this, I'm
>> happy with either solution, your choice.
> 
> You do have a point. I'll take a look how the two options look like,
> but maybe your way is better after all.

I whipped up a quick fix using my approach so that I can start working
on debugging the usb_role_switch_get call in tcpm.c returning NULL.

I've attached it, feel free to use this for v4 of the series if you
decide to go with this approach.

Regards,

Hans


> 
> thanks,
> 

--------------C16F2A63C9CF340E7A34C72F
Content-Type: text/x-patch;
 name="0001-FIXUP-usb-typec-Registering-real-device-entries-for-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-FIXUP-usb-typec-Registering-real-device-entries-for-.pa";
 filename*1="tch"

>From 47154195c05dc7c8b3373de9603b06c2f435588a Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 17 Apr 2019 17:58:17 +0200
Subject: [PATCH v2] FIXUP: "usb: typec: Registering real device entries for
 the muxes"

Check the dev_name suffix so that we do not return the first registered
device when a mux and switch share the same parent and fwnode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/typec/mux.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index c7d4a2dd454e..a28803544301 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -22,9 +22,21 @@ static int name_match(struct device *dev, const void *name)
 	return !strcmp((const char *)name, dev_name(dev));
 }
 
-static int fwnode_match(struct device *dev, const void *fwnode)
+static bool dev_name_ends_with(struct device *dev, const char *suffix)
 {
-	return dev_fwnode(dev) == fwnode;
+	const char *name = dev_name(dev);
+	const int name_len = strlen(name);
+	const int suffix_len = strlen(suffix);
+
+	if (suffix_len > name_len)
+		return false;
+
+	return strcmp(name + (name_len - suffix_len), suffix) == 0;
+}
+
+static int switch_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-switch");
 }
 
 static void *typec_switch_match(struct device_connection *con, int ep,
@@ -37,7 +49,7 @@ static void *typec_switch_match(struct device_connection *con, int ep,
 			return NULL;
 
 		dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
-					fwnode_match);
+					switch_fwnode_match);
 	} else {
 		dev = class_find_device(&typec_mux_class, NULL,
 					con->endpoint[ep], name_match);
@@ -167,6 +179,11 @@ EXPORT_SYMBOL_GPL(typec_switch_get_drvdata);
 
 /* ------------------------------------------------------------------------- */
 
+static int mux_fwnode_match(struct device *dev, const void *fwnode)
+{
+	return dev_fwnode(dev) == fwnode && dev_name_ends_with(dev, "-mux");
+}
+
 static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 {
 	const struct typec_altmode_desc *desc = data;
@@ -226,7 +243,7 @@ static void *typec_mux_match(struct device_connection *con, int ep, void *data)
 
 find_mux:
 	dev = class_find_device(&typec_mux_class, NULL, con->fwnode,
-				fwnode_match);
+				mux_fwnode_match);
 
 	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
 }
-- 
2.21.0


--------------C16F2A63C9CF340E7A34C72F--
