From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: ACPI: EC: Fix logspam in "GPE storm avoidance" code
Date: Wed, 29 Oct 2008 09:51:18 +0000
Message-ID: <49083216.60202@tuffmail.co.uk>
References: <49071C33.7030308@tuffmail.co.uk> <4907590E.4070104@suse.de> <20081029001231.GA22985@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:40949 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYJ2JvX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 05:51:23 -0400
Received: by ik-out-1112.google.com with SMTP id c29so1180158ika.5
        for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2008 02:51:21 -0700 (PDT)
In-Reply-To: <20081029001231.GA22985@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Henrique de Moraes Holschuh wrote:
> On Tue, 28 Oct 2008, Alexey Starikovskiy wrote:
>   
>> Alan Jenkins wrote:
>>     
>>> <http://bugzilla.kernel.org/show_bug.cgi?id=11841>
>>> "plenty of line "ACPI: EC: non-query interrupt received,
>>>  switching to interrupt mode" in dmesg"
>>>       
>> Probably, it is better to make pr_debug().
>>     
>
> Please don't do that.  This code has had a lot of churn, and *regressions*
> as of lately, and sometimes we only notice these because we see those
> messages in the logs.  Moving them to pr_debug() pretty much makes them
> utterly useless in a large number of the cases they could be of help.
>
> Besides, I very much doubt we will stop seing EC interrupt crappage. Not
> only our code is NOT good and resilient enough yet (if it were, there
> wouldn't be so many patches flying about it), the vendors are obviously
> getting this wrong at a fast rate.
>
> We need those messages.  Rate-limit them, but don't hide them or move them
> to pr_debug, please.
>   

Please have a look at the dmesg attached to the bug.  They're already
rate-limited.

When in GPE storm avoidance mode, they will trigger once for each
transaction.  Transactions happen frequently, and will happen
continually once e.g. gnome-power-manager is polling the battery level. 
In this special case, they're not a useful message to users or
blackbox-level testers; they are only useful as part of a full DEBUG
trace that actually shows the transactions.

My original patch suppresses the message in this particular case, but it
preserves it for the common non-storm case, where it may provide useful
information.  And the message would still happen once on boot, before
the GPE storm is detected.  Unfortunately my patch also makes the driver
a little less robust.  If the robustness issue can be addressed, do you
accept that it's a good idea to suppress the flood of duplicate messages
reported in this bug?

We already have... damn.  I think you missed a more important omission. 
There _used_ to be a message that says we've switched to storm avoidance
mode.  However, it was removed in the latest re-write.  This bug report
suggests that a) the cause would have been more obvious if we had the
GPE storm message, and b) the stormy case wasn't really tested so we
really do need a message, in case it goes wrong.

Thanks
Alan
