From: Thomas Renninger <trenn@suse.de>
Subject: Re: USB suspend/resume in linux
Date: Fri, 13 Oct 2006 10:39:00 +0200
Message-ID: <1160728740.2096.243.camel@queen.suse.de>
References: <0FB24CC078F78248B19595A43F00E01FD92D24@fmsmsx413.amr.corp.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:10369 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750832AbWJMI2f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Oct 2006 04:28:35 -0400
In-Reply-To: <0FB24CC078F78248B19595A43F00E01FD92D24@fmsmsx413.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kaburlasos, Nikos" <nikos.kaburlasos@intel.com>
Cc: linux-acpi@vger.kernel.org

On Thu, 2006-10-12 at 22:54 -0700, Kaburlasos, Nikos wrote:
> Does anyone know whether the linux USB drivers support the suspend
> feature on idle USB ports (i.e. the port has been idle for sometime and
> so the driver transitions it in to a low-power 'suspend' state) while
> the system is active and in S0 state? As far as I know, Windows don't
> support that, I was wondering if linux does.
> 
> Please note, I have no background on linux or in OS programming (I am a
> hardware guy), so please be gentle with the level of technical detail in
> your response :-)

AFAIK linux is not doing that.
Therefore the ohci (also uhci?) drivers need to poll the ports quite
often even there is no device attached. This makes C-states less
efficient (what should save more power than the suspended USB ports). I
thought Windows is doing that, I at least heard Mac OS is doing it like
that, but I don't know for sure.
The proper solution to avoid polling should be to suspend idle ports,
stop polling and wait for some kind of resume/attach event, but AFAIK
nobody really works on that. Would be nice if someone gives this a
try...

  Thomas

