From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Acer Travermate 8005 and battery info
Date: Tue, 5 Oct 2004 16:39:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041005143951.GB4723@openzaurus.ucw.cz>
References: <415C270F.5050306@lanil.mine.nu> <20041001102926.GD18786@elf.ucw.cz> <415D8CCF.8050602@lanil.mine.nu> <20041001194739.GE1100@openzaurus.ucw.cz> <41603BA0.9090900@lanil.mine.nu> <20041003203457.GD3379@elf.ucw.cz> <41617104.2040302@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41617104.2040302-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> |>>Search maillist archives, look up "smart battery specification" in
> google.
> |>>If you are willing to spend few days writing driver, let me know.
> |>
> |>Ive checked out some specs now and Im willing to give it a shot but 
> Ive
> |>no idea on where to start.. Ive checked out my DSL and I find 
> nothing
> |>containing SBS in it. Suggestions?
> |
> |
> | Right start probably is drivers/i2c. I collected these links:
> 
> i'm willing to participate also. but first, let me see if i
> understood... the first step should be building a driver to 
> communicate
> with the smbus via i2c. am i right?

I believe that smbus is subset of i2c... So first step would be
"make it talk with smart battery over i2c".

Anyway I may be wrong. You'll know for sure when the patch starts
working :-).
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
