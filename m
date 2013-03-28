From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Thu, 28 Mar 2013 20:42:50 +0100
Message-ID: <51549D3A.3000406@fold.natur.cuni.cz>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <2457825.yjlrJCricN@vostro.rjw.lan> <CAErSpo6oNPKn5eQV_ERaw1659-9N_Dti7ewKiRfVCy2Xw9rzbg@mail.gmail.com> <1433753.0tcctuHSKe@vostro.rjw.lan> <51547D45.6030106@fold.natur.cuni.cz> <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <20130328182326.GA5995@xanatos> <CAErSpo4PeJFikKZQvZVTFzZDu+mA--MsgbP7WZYBdd0hJBpAow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:52485 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751160Ab3C1Tmy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Mar 2013 15:42:54 -0400
In-Reply-To: <CAErSpo4PeJFikKZQvZVTFzZDu+mA--MsgbP7WZYBdd0hJBpAow@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Bjorn Helgaas wrote:
> On Thu, Mar 28, 2013 at 12:23 PM, Sarah Sharp

>>
>> Bjorn, I see that you're encouraging people to have their bugs and
>> symptoms in a bug tracker.  I've also been doing that within Intel, in a
>> private JIRA issue tracker.  I've been discussing if we can duplicate
>> some bugs or features that don't contain Intel confidential information
>> to a public JIRA at 01.org.  I don't really want to use
>> bugzilla.kernel.org because, quite frankly, the interface is archaic,
>> and in the past I've gotten pushback from other devs about tracking
>> "someday" features in there.
> 
> My main concern is that often there's more information relevant to a
> change than it makes sense to put in the changelog, so I like to
> include a URL to that additional info.  I don't really care if that's
> for a mailing list archive, a bugzilla, a JIRA instance, etc.  Issue
> trackers are more convenient than mailing lists for collecting dmesg
> logs, acpidumps, etc.  The archaic bugzilla interface notwithstanding,
> I'm not sure it would be an improvement to have a collection of dozens
> of issue trackers controlled by random organizations.  I'd rather have
> a single place and confidence that it will stick around.

What's wrong with bugzilla? It's nice and more appealing than Jira. From
a user perspective I always found Jira ugly. sorry to say that. ;-)

Martin
