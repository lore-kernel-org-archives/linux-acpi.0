From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH]Modular C-state policy
Date: Mon, 24 Oct 2005 10:05:08 +0800
Message-ID: <1130119508.3947.4.camel@linux-hp.sh.intel.com>
References: <1129083270.4159.10.camel@linux-hp.sh.intel.com>
	 <20051022192940.GB7082@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20051022192940.GB7082-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Venki <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2005-10-22 at 21:29 +0200, Dominik Brodowski wrote:
> Hi,
> 
> On Wed, Oct 12, 2005 at 10:14:29AM +0800, Shaohua Li wrote:
> 
> > +	/* FIXME: we currently only support one extra policy */
> 
> Why is that?
For convenience, we now just support adding one extra policy, as we
guess replacing C-state policy might not be popular. The limitation can
removed easily.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
