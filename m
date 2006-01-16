From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: lid
Date: Mon, 16 Jan 2006 10:35:23 +0100
Message-ID: <43CB68DB.2000105@suse.de>
References: <43C93E89.4000908@xover.htu.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43C93E89.4000908-xHt1aDgCSJ+En27Z3eobquNwNpCqAOSQ@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabian Zeindl <fabian-xHt1aDgCSJ+En27Z3eobquNwNpCqAOSQ@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Fabian Zeindl wrote:
> Hi
> 
>  When my laptop is started and my laptop lid is open,
> /proc/acpi/button/lid/LID/state says "closed". When I close it once and
> open it again once the value is set correctly. This is very annoying
> cause my screensaver always invokes on startup.
> 
> I have an Acer Travelmate 243LC.
> 
I saw another report like that recently?
Better you open a bug on buzilla.kernel.org.
Also attach full dmesg (with button module loaded) and acpidmp there.
Please add me to CC.

     Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
