From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.24-rc1 regression] AC adapter state does not change after resume
Date: Tue, 30 Oct 2007 22:24:55 +0100
Message-ID: <200710302224.55947.rjw@sisk.pl>
References: <200710302324.52822.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754651AbXJ3VIj@vger.kernel.org>
In-Reply-To: <200710302324.52822.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, 30 October 2007 21:24, Andrey Borzenkov wrote:
> I suspect new ACPI AC adapter code but have to add some printk's to be sure.
> 
> To reproduce - plug in AC cord, suspend, unplug, resume - kpowersave and sysfs 
> still show AC adapter online. Or other way round.

Is this a resume from RAM or from disk?

Does 2.6.23 work correctly?

Rafael
