From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] Configure cpuidle governors by default
Date: Thu, 13 Sep 2007 14:30:37 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4033A351F@orsmsx415.amr.corp.intel.com>
References: <20070913203917.GA1183@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56524 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755506AbXIMVaj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Sep 2007 17:30:39 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20070913203917.GA1183@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, abelay@novell.com

>> Quoting Len "Do not give an option to users to shoot themselves in
the foot".

Odd, I thought that was a Windows attitude, and Unix/Linux was the
opposite.

"All the rope and more..."

Bob

-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Venki Pallipadi
Sent: Thursday, September 13, 2007 1:39 PM
To: Brown, Len
Cc: linux-acpi@vger.kernel.org; abelay@novell.com
Subject: [PATCH] Configure cpuidle governors by default


Quoting Len "Do not give an option to users to shoot themselves in the
foot".

Remove the configurability of ladder and menu governors as they are
needed for default policy of cpuidle. That way users will not be able to
have cpuidle without any policy loosing all C-state power savings.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.23-rc6/drivers/cpuidle/Kconfig
===================================================================
--- linux-2.6.23-rc6.orig/drivers/cpuidle/Kconfig
+++ linux-2.6.23-rc6/drivers/cpuidle/Kconfig
@@ -1,4 +1,3 @@
-menu "CPU idle PM support"
 
 config CPU_IDLE
 	bool "CPU idle PM support"
@@ -10,30 +9,13 @@ config CPU_IDLE
 	  If you're using a mobile platform that supports CPU idle PM
(e.g.
 	  an ACPI-capable notebook), you should say Y here.
 
-if CPU_IDLE
-
-comment "Governors"
-
 config CPU_IDLE_GOV_LADDER
-	tristate "'ladder' governor"
+	bool
 	depends on CPU_IDLE
 	default y
-	help
-	  This cpuidle governor promotes and demotes through the
supported idle
-	  states using residency time and bus master activity as
metrics.  This
-	  algorithm was originally introduced in the old ACPI processor
driver.
 
 config CPU_IDLE_GOV_MENU
-	tristate "'menu' governor"
+	bool
 	depends on CPU_IDLE && NO_HZ
 	default y
-	help
-	  This cpuidle governor evaluates all available states and
chooses the
-	  deepest state that meets all of the following constraints: BM
activity,
-	  expected time until next timer interrupt, and last break event
time
-	  delta.  It is designed to minimize power consumption.
Currently
-	  dynticks is required.
-
-endif	# CPU_IDLE
 
-endmenu
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
