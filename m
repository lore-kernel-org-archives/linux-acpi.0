From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: Problem suspending ASUS A7V8X based desktop
Date: Fri, 12 Aug 2005 19:34:55 +0200
Message-ID: <20050812173455.GA11307@message-id.gmane0305.slipkontur.de>
References: <20050807062525.GA17750@tangens.sinus.cz> <20050808142857.GB1913@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050808142857.GB1913-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

On Mon, Aug 08, 2005 at 04:28:57PM +0200, Pavel Machek wrote:
> Hi!
>  
> >   Video card used:
> > 01:00.0 VGA compatible controller: nVidia Corporation NV31 [GeForce FX 5600] (rev a1)
> > operated with Nvidia driver (build 7667). This drivers seems to be PM-aware.
> > Happens identically on all the recent kernels including 2.6.13-rc5.
> >   Any ideas ?
> 
> Anything mentioning nvidia proprietary drivers is off-topic here. Try
> again with open-source drivers.

The problem here is, that the NVidia drivers can bring the card back from
suspend while the open source nv driver can't.

Life is hard.
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
