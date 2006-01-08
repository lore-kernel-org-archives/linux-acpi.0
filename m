From: Thomas Andrews <tandrews-Dza9YrynN5pWaveUIWBRJg@public.gmane.org>
Subject: enabling hotkey debugging
Date: Sun, 8 Jan 2006 09:09:44 +0200
Message-ID: <20060108070944.GA4728@grok.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I would like to use /proc/acpi/hotkey/... for debugging my AML. I see
people using commands like this:

    echo "0:\\_GPE:_L17:\\_GPE:_L17:10001:1" > /proc/acpi/hotkey/poll_config
    echo "10001:0:1:0" > /proc/acpi/hotkey/action

and I see that it's documented in Documentation/acpi-hotkey.txt

How do I enable this functionality ? I have 
    CONFIG_ACPI_HOTKEY=y
in kernel 2.6.15

Thanks,
Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
