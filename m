From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: Acer TM636 won't wakeup after S3, USB, i8042
Date: Tue, 11 Jan 2005 09:23:04 -0700
Message-ID: <1105460584.31942.16.camel@eeyore>
References: <20050111003537.13142400@bonenpikster.drs.p>
	 <200501102112.55237.dtor_core@ameritech.net>
	 <20050111151253.10083aa4@orfeo.nikhef.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050111151253.10083aa4-acHaiI0CM+haAVKTNDtesg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tim Dijkstra <newsuser-TpnWJeB+oO0hKRfeEwdQzg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-01-11 at 15:12 +0100, Tim Dijkstra wrote:
> On Mon, 10 Jan 2005 21:12:55 -0500
> Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org> wrote:
> > Kernel attempts to resume keyboard controller but it is so dead that
> > it's not responding to even the basic command...
> 
> OK, that's definitely not good... Does somebody has an idea what the
> problem could be? Maybe what to do about it? 

Have you tried booting with "pci=routeirq"?  If you have
CONFIG_PNPACPI=y, can you try turning that off?  And these
patches fix a known suspend/resume issue:

    http://www.ussg.iu.edu/hypermail/linux/kernel/0501.0/0284.html
    http://www.ussg.iu.edu/hypermail/linux/kernel/0501.0/0548.html





-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
