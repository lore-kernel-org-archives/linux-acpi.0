From: Len Brown <lenb@kernel.org>
Subject: [PATCH] Re: Dependency chain of new thermal driver
Date: Tue, 18 Mar 2008 01:31:30 -0400
Message-ID: <200803180131.30662.lenb@kernel.org>
References: <20080316155659.7ab2446d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46889 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097AbYCRFxO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Mar 2008 01:53:14 -0400
In-Reply-To: <20080316155659.7ab2446d@hyperion.delvare>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, LM Sensors <lm-sensors@lm-sensors.org>, linux-acpi@vger.kernel.org

On Sunday 16 March 2008, Jean Delvare wrote:
> Hi Rui,
> 
> I am testing your new thermal driver and I am not very happy with the
> dependencies introduced by this driver. The ACPI thermal driver selects
> the generic thermal driver, which in turn selects the hwmon base
> module. As the generic thermal driver's configuration option is a
> boolean, this means that as soon as one selects the ACPI thermal driver
> (built-in or modular), the hwmon thermal driver has to be built into
> the kernel. This is a problem especially when both the ACPI_THERMAL and
> THERMAL options default to y.
> 
> I fail to see why we are using select at all. The ACPI thermal driver
> clearly works without the generic thermal driver (even though the
> generic interface is preferred now.) Likewise, the generic thermal
> interface driver doesn't need the hwmon base module to work; the hwmon
> interface is only an extension, so it should be possible to build the
> generic thermal driver without hwmon support. On top of that, I really
> would like to be able to build the generic thermal driver as a module.
> 
> One of the reasons why I would like this to change is this bug:
> https://bugzilla.redhat.com/show_bug.cgi?id=437637
> http://bugzilla.kernel.org/show_bug.cgi?id=10259
> (At the moment I think both reports are the exact same bug.)
> 
> We will have to fix this bug of course (not sure how...) but the fact
> that the users can't temporarily remove the generic thermal driver is a
> problem both for bug investigation and for working around the bug until
> it's fixed. I really would like to be able to tell the user "rmmod this
> module until we come up with a fix", but right now I can't.
> 
> A more modular setup would give us much more flexibility both at build
> time and when bugs are reported. Please think about it.
> 

You are absolutely right -- this is gone from 2.6.25,
lets get it right in 2.6.26.

BTW. speaking of 2.6.26....
the patch below might become helpful.  For it would
be nice if at build-time we could just have hwmon_device_register()
fail, rather than put a bunch of #ifdef HWMON in our code.

thanks,
-Len

Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 6b6ee70..68968cc 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -16,9 +16,13 @@
 
 #include <linux/device.h>
 
+#ifdef CONFIG_HWMON
 struct device *hwmon_device_register(struct device *dev);
-
 void hwmon_device_unregister(struct device *dev);
+#else
+static struct device *hwmon_device_register(struct device *dev) { return ERR_PTR(-ENODEV); };
+static void hwmon_device_unregister(struct device *dev) { return; };
+#endif
 
 /* Scale user input to sensible values */
 static inline int SENSORS_LIMIT(long value, long low, long high)

