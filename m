From: Spam Guard <spamguard-ihVZJaRskl1bRRN4PJnoQQ@public.gmane.org>
Subject: ACPI4Linux compatibility with Suspend2
Date: Fri, 15 Jul 2005 10:44:01 -0500
Message-ID: <42D7D9C1.40907@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

I am currently using the 2.6.12.2 kernel.  On previous kernels (2.6.9
being my last), I was able to install both ACPI4Linux and Suspend2
without any issues, and my system seemed to work very nicely.

With this new kernel, I installed Suspend2 first (because that's the
more important patch for me as an end-user).  I then tried to apply the
ACPI4Linux patch.  Almost everything patched fine, with a few lines that
were understandably offset from the Suspend2 patch.  But one hunk was
problematic because of changes Suspend2 had made.

I know a little C, so I resolved the problem as cleanly as I could to
get a clean compile.  For those interested, here's *my* final version of
the one function in /drivers/pci/pci.c that was problematic (it
hybridizes changes between Suspend2 and ACPI4Linux):


pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
{
        int     ret;
        if (!pci_find_capability(dev, PCI_CAP_ID_PM))
                return PCI_D0;

        if (platform_pci_choose_state) {
                ret = platform_pci_choose_state(dev, state);
                if (ret >= 0)
                        state.event = ret;
        }
        switch (state.event) {
        case EVENT_ON:
        case EVENT_FREEZE:
                return PCI_D0;
        case EVENT_SUSPEND:
                return PCI_D3hot;
        default:
                printk("They asked me for state %d\n", state.event);
                BUG();
        }
        return PCI_D0;
}


Now, I'm noticing that Suspend isn't working quite as gracefully as I
did in prior kernels, and I've come to wonder if I overstepped
reasonable boundaries in forcing ACPI4Linux's patch. 

I run a Thinkpad T42.  How behind the curve is the stock 2.6.12.2 kernel
in regards to this hardware?  How slowly do improvements in ACPI4Linux
roll down into the stock kernel? 

I appreciate any/all feedback.  In the meantime for the sake of safety,
I'm going to roll back to the life without ACPI4Linux.  However, I'm
curious what kind of ACPI features I'll loose in doing so.

Thanks,
Sukant

p.s. I haven't subscribed to this mailing list, so I'm hoping that
responses are copied to me.  Please let me know if the proper thing to
do is to subscribe.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
