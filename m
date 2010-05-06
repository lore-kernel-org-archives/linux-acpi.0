From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [PATCH 2/2] thinkpad_acpi: Hook volume events
Date: Thu, 6 May 2010 13:47:48 +0100
Message-ID: <20100506124748.GA22190@srcf.ucam.org>
References: <1272916980-11835-1-git-send-email-mjg@redhat.com>
	<1272916980-11835-2-git-send-email-mjg@redhat.com>
	<20100505113004.GA19480@khazad-dum.debian.net>
	<20100505132030.GA24372@srcf.ucam.org>
	<20100506030239.GB19265@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100506030239.GB19265-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, May 06, 2010 at 12:02:39AM -0300, Henrique de Moraes Holschuh wrote:

> Reading that stuff ain't cheap.  Either a locked trip through the LPC bus
> for the CMOS nvram, or ACPI EC I/O (which is even worse, I fear.  That EC is
> also hooked to LPC, and there's a lot more code involved).
> 
> I really would rather not enable it on boxes where it isn't required.  And
> we know which ones are those: IBM thinkpads where the all-available-hotkeys
> mask has the bits for the volume hotkeys set.

Ok, that's easy enough to do. I'll rework and send that.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

------------------------------------------------------------------------------
