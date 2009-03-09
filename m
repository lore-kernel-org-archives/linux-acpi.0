From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29-rc7 does not power off on halt
Date: Tue, 10 Mar 2009 00:47:05 +0100
Message-ID: <200903100047.05337.rjw@sisk.pl>
References: <87vdqishgp.fsf@tac.ki.iif.hu> <200903092222.18562.rjw@sisk.pl> <87sklme2j3.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41524 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbZCIXrT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 Mar 2009 19:47:19 -0400
In-Reply-To: <87sklme2j3.fsf@tac.ki.iif.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-acpi@vger.kernel.org

On Monday 09 March 2009, Ferenc Wagner wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Monday 09 March 2009, Ferenc Wagner wrote:
> > 
> >> The current git kernel doesn't switch off power as the last step of
> >> system halt (-p) on our Atom systems.  Everything seems to be all
> >> right, just the power remains on.  Is this a known issue perhaps?
> >
> > Not really.  Does it happen with 2.6.28 too?
> 
> I didn't test 2.6.28, but 2.6.24 exhibits the same issue.  I can try
> 2.6.28.7 (or any other version) if you deem it useful.  I started
> compiling, but probably won't have a chance to test until tomorrow.

Yes, it would be helpful to know whether or not this is a new issue.

Thanks,
Rafael
