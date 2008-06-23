From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [RFC] Allow notifications on method execution
Date: Mon, 23 Jun 2008 10:18:40 -0300
Message-ID: <20080623131840.GB11312@khazad-dum.debian.net>
References: <20080620152227.GA11828@srcf.ucam.org> <1214204194.25786.97.camel@yakui_zhao.sh.intel.com> <20080623130900.GB3416@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36706 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752105AbYFWNSq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jun 2008 09:18:46 -0400
Content-Disposition: inline
In-Reply-To: <20080623130900.GB3416@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br, "Lin, Ming M" <ming.m.lin@intel.com>

On Mon, 23 Jun 2008, Henrique de Moraes Holschuh wrote:
> On Mon, 23 Jun 2008, Zhao Yakui wrote:
> > On Fri, 2008-06-20 at 16:22 +0100, Matthew Garrett wrote:
> > > Various bits of hardware (some Thinkpads, for example) will execute ACPI 
> > > methods in response to events but won't generate any notifications. It 
> > > would be nice to be able to receive notifications on those updates in 
> > > order to avoid polling. How about something like the following?
> > Very good idea. From the description the notification can be received
> > when some ACPI methods are executed. 
> > But it touches the ACPICA source code. Maybe it is uneasy to accept. 
> > And I have a question about this.
> >   Asynchronous or synchronous notification event? It seems that
> 
> I'd do fine with an asynchronous blocking or SCRU (blocking) notify
> chain for thinkpad-acpi.  No need for synchronous operation, I'd not be
> using this API to hotpatch the AML or anything of the sort.

But I *really* do think you don't want a table-wide notify chain, something
more fine-grained is better, or it will be a performance hog if too many
drivers use it.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
