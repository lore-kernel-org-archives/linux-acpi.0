From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [patch 1/3] acpi: dock driver
Date: Sun, 16 Apr 2006 09:28:40 -0400
Message-ID: <44424688.3050802@redhat.com>
References: <20060412221027.472109000@intel.com>	 <1144880322.11215.44.camel@whizzy>  <20060412222735.38aa0f58.akpm@osdl.org> <1145054985.29319.51.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750741AbWDPN3e@vger.kernel.org>
In-Reply-To: <1145054985.29319.51.camel@whizzy>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, len.brown@intel.com, greg@kroah.com, linux-acpi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, mochel@linux.intel.com, arjan@linux.intel.com, muneda.takahiro@jp.fujitsu.com, pavel@ucw.cz, temnota@kmv.ru
List-Id: linux-acpi@vger.kernel.org

I'm not sure if my previous reply made it out to the list and everyone 
else.  I'm in the process of switching email addresses :(.  Sorry if 
this is a repeat Kristen, et al.... My apologies if this is the case ...

>+static struct dock_dependent_device * alloc_dock_dependent_device(acpi_handle handle)
>+{
>+	struct dock_dependent_device *dd;
>+
>+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
>+	if (dd) {
>+		dd->handle = handle;
>+		INIT_LIST_HEAD(&dd->list);
>+		INIT_LIST_HEAD(&dd->hotplug_list);
>+	}
>+	return dd;
>+}
>+
>
>  
>
What do you do if this returns NULL (ie, kzalloc did not succeed)?  Then 
you blindly use the pointer elsewhere in the code?

P.

P.
