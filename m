From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: smartbattery support
Date: Thu, 7 Oct 2004 11:41:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041007094109.GA534@openzaurus.ucw.cz>
References: <41630B6D.2000107@mega.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41630B6D.2000107-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
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

> i decided to change the subject so that the thread could more easily 
> be followed by others.
> 
> i read some things also, but i disagree with christian. i think that 
> smbus patch is not the way to go. don't get me wrong! i'm also just 
> scratching the surface. for what i read, those patches put smbus bios 
> support into the kernel.

Agreed, we do not want to touch BIOS.

> 2. what exactly should the i2c driver do? should it just know the 
> smartbattery address and ask generic questions made by userland 
> programs? or should it do all the work and retrive charge rates and 
> capacity information and such?

I believe doing all the work is right.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
