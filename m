From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI: EC: Fix logspam in "GPE storm avoidance" code
Date: Tue, 28 Oct 2008 22:12:31 -0200
Message-ID: <20081029001231.GA22985@khazad-dum.debian.net>
References: <49071C33.7030308@tuffmail.co.uk> <4907590E.4070104@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33376 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752854AbYJ2AMq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Oct 2008 20:12:46 -0400
Content-Disposition: inline
In-Reply-To: <4907590E.4070104@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Tue, 28 Oct 2008, Alexey Starikovskiy wrote:
> Alan Jenkins wrote:
>> <http://bugzilla.kernel.org/show_bug.cgi?id=11841>
>> "plenty of line "ACPI: EC: non-query interrupt received,
>>  switching to interrupt mode" in dmesg"
> Probably, it is better to make pr_debug().

Please don't do that.  This code has had a lot of churn, and *regressions*
as of lately, and sometimes we only notice these because we see those
messages in the logs.  Moving them to pr_debug() pretty much makes them
utterly useless in a large number of the cases they could be of help.

Besides, I very much doubt we will stop seing EC interrupt crappage. Not
only our code is NOT good and resilient enough yet (if it were, there
wouldn't be so many patches flying about it), the vendors are obviously
getting this wrong at a fast rate.

We need those messages.  Rate-limit them, but don't hide them or move them
to pr_debug, please.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
