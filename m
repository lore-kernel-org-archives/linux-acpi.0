From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: JVC 731 ACPI problems
Date: Wed, 1 Jun 2005 11:44:17 +0200
Message-ID: <20050601094417.GB23114@elf.ucw.cz>
References: <20050530205714.GD29805@widecut.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050530205714.GD29805-l2ajQKOt+HbR7s880joybQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: moe <moe-9AEwkcPRwFQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Po 30-05-05 22:57:15, moe wrote:
> hi,
> 
> i recently bought a JVC 731 Centrino/Pentium M subnotebook.
> is it possible to make acpi work properly on it?
> 
> right now i have various problems under vanilla kernel 2.6.10;
> e.g. the remaining battery time is way overestimated, standby and
> suspend to ram/disk don't work.
> 
> the missing suspend-functionality bothers me the most since it
> significantly limits the machines runtime.
> 
> the closest approximation to a proper standby that i can get is:
> 
> 1. kill all running processes except the bare minimum
> 2. echo -n "mem" >/sys/power/state
> 3. the machine shuts down as expected, the power LED blinks
> 4. when i try to wake it up (power button) it turns on, the fan goes to max
>    but nothing more happens (screen remains black). at that point i have to
>    use hardware-reset.

See Doc*/power/video.txt.
									Pavel


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
