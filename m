From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: Bisection result: eeepc hotk breakage
Date: Fri, 31 Oct 2008 17:54:52 +0300
Message-ID: <490B1C3C.2080305@suse.de>
References: <4907A511.3040603@tuffmail.co.uk> <4907A856.3050204@gmail.com> <4908307C.8060503@tuffmail.co.uk> <49086F67.1030607@suse.de> <490872BF.2010908@tuffmail.co.uk> <4908C714.5040104@tuffmail.co.uk> <4908C8EB.1010403@suse.de> <490ADD62.7090507@tuffmail.co.uk> <490B0D48.7040209@suse.de> <490B0DCB.40009@tuffmail.co.uk> <490B12F2.9050903@suse.de> <490B132A.3000904@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050002080409030708040607"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:37556 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbYJaOyx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Oct 2008 10:54:53 -0400
In-Reply-To: <490B132A.3000904@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Matthew Wilcox <willy@linux.intel.com>

This is a multi-part message in MIME format.
--------------050002080409030708040607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Jenkins wrote:
> Alexey Starikovskiy wrote:
>> Alan Jenkins wrote:
>>> Alexey Starikovskiy wrote:
>>>> Alan Jenkins wrote:
>>>>> Alexey Starikovskiy wrote:
>>>>>> Alan Jenkins wrote:
>>>>>>> Well, that didn't work.
>>>>>> Pity...
>>>>>> Could you produce a debug log from EC?
>>>>>> Probably it's a good time to open a new bug report...
>>>>> <http://bugzilla.kernel.org/show_bug.cgi?id=11917>
>>>>> "Asus Eee PC hotkeys stop working after prolonged usage"
>>>>>
>>>>> I stuck at it, found a reliable test and bisected successfully.
>>>>> 2.6.28-rc2 is broken, but I can fix it by reverting the bad commit.
>>>>> (There were some conflicts, I fixed up the dock driver manually and
>>>>> avoided building the rest).
>>>> Alan, to make things clear -- reverting following commit makes EC work
>>>> without
>>>> a problem?
>>>>
>>>
>>> Yes, that's right.
>> Great!
>> What kernel version is that -- 32 or 64?
> 
> 32 bit, my EeePC doesn't do 64.
is the attached patch enough to fix ?


--------------050002080409030708040607
Content-Type: text/x-diff;
 name="x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x.patch"

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index ef42316..e0f1534 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -751,6 +751,7 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 		return status;
 	ec->gpe = tmp;
 	/* Use the global lock for all EC transactions? */
+	tmp = 0;
 	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
 	ec->global_lock = tmp;
 	ec->handle = handle;

--------------050002080409030708040607--
