From: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] Re: PATCH: /proc/acpi/alarm: handle day-of-month
 wraparound on readback
Date: Mon, 1 Dec 2008 23:32:10 +0100
Message-ID: <20081201233210.598f2dcf@i1501.lan.towertech.it>
References: <200806222042.13929.david-b@pacbell.net>
	<4934176F.6080900@rtr.ca>
	<alpine.LFD.2.00.0812011311490.3197@localhost.localdomain>
	<49346212.3050102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753277AbYLAWc1@vger.kernel.org>
In-Reply-To: <49346212.3050102@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: lkml@rtr.ca, Len Brown <lenb@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 01 Dec 2008 17:15:46 -0500
Mark Lord <lkml@rtr.ca> wrote:

> Yeah.. bit of a nuisance that.
> I regularly apply this patch to my own kernels:

 While it will certainly work, maybe it's time to switch
 to /sys/class/rtc/rtcX/wakealarm . 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
