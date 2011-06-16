From: Phillip Susi <psusi@iradimed.com>
Subject: Re: Wakeup and S states
Date: Thu, 16 Jun 2011 09:48:59 -0400
Message-ID: <4DFA09CB.9040909@iradimed.com>
References: <4DF8CBC3.5070801@cfl.rr.com> <20110615154457.GA13863@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exhub016-2.exch016.msoutlookonline.net ([207.5.72.164]:36783
	"EHLO EXHUB016-2.exch016.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751550Ab1FPN7I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Jun 2011 09:59:08 -0400
In-Reply-To: <20110615154457.GA13863@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

On 06/15/2011 11:44 AM, Matthew Garrett wrote:
> On Wed, Jun 15, 2011 at 11:12:03AM -0400, Phillip Susi wrote:
>
>> Conversely, if an ethernet controller is capable of waking up the
>> system from S5, that does not mean we want it left powered on and
>> capable of doing so when we shut the machine off, but had WOL
>> enabled.  Is there no way to enable wakeup only from S3, even though
>> the device is capable of lower levels?
>
> Well, that's the usual use-case for WoL. If you don't want a device to
> wake up from a specific sleep state, disable that device before entering
> that sleep state.

I am reading reports from some users that their laptop keeps the
ethernet interface powered on and runs down the battery after shutting
down.  It seems they are capable of waking the system from S5.  It 
appears that if the interface is not ethdown'ed in /etc/init.d/halt, 
then it remains on.  Are you saying that it is up to userspace to 
disable WOL and down the interface before shutting down?

Also strangely, ethtool reports that WOL is enabled for magic packet ( 
which I guess comes from the bios default, I checked my desktop and it 
also appears to default to wol: g, but can only wakeup from s4 ), but 
/proc/acpi/wakeup claims wakeup for the device is disabled.  They should 
always agree shouldn't they?

