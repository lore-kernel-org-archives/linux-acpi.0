From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Date: Sat, 6 Nov 2004 00:50:32 -0500
Message-ID: <200411060050.32816.dtor_core@ameritech.net>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105204209.GA1204@kroah.com> <20041105211848.A21098@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261308AbUKFFui@vger.kernel.org>
In-Reply-To: <20041105211848.A21098@unix-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>, tokunaga.keiich@jp.fujitsu.com, motoyuki@soft.fujitsu.com, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, rml@novell.com, len.brown@intel.com, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Saturday 06 November 2004 12:18 am, Keshavamurthy Anil S wrote:
> Also, since you have brought this, I have one another question to you.
> Now in the new kernel, I see whenever anybody calls sysdev_register(kobj),
> an "ADD" notification is sent. why is this? I would like to call
> kobject_hotplug(kobj, ADD) later.
> 

Hi Anil,

Please take a look at drivers/base/firmware_class.c to see how one can
suppress initial hotplug notification and call hotplug when object is
finally ready. Hopefully you can use similar solution.

-- 
Dmitry
