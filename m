From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: AE_BAD_HEX_CONSTANT
Date: Fri, 12 Nov 2004 16:20:48 +0100
Message-ID: <20041112152048.GE31422@poupinou.org>
References: <20041109193331.930.qmail@web41101.mail.yahoo.com> <41911F58.6020300@root.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41911F58.6020300-Y6VGUYTwhu0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Cc: Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 09, 2004 at 11:49:44AM -0800, Nate Lawson wrote:
> 
>                         Name (BT0I, Package (0x0D)
>                         {
>                             0x01,
>                             0x19C8,
>                             0x19C8,
>                             0x01,
>                             0x39D0,
>                             0x014A,
>                             0xDC,
>                             0x012C,
>                             0x0294,
>                             "ANA",
>                             "110",
>                             "Lion",
>                             0x00
>                         })
> 
> Looking more carefully, it looks like commenting out just the last line 
> ("Acer") would suffice.  Index 0xC is actually an integer (0x00) so this 
> is what triggers the Integer conversion.  I'm not sure how the 
> conversion rules should be modified to take this into account.
> 

I suggest to replace the last integer with a string like "Acer".  Since
anyway BT0I is expected to be a package returned by a _BIF method, it
must be compatible with ACPI spec (look at 11.2.2.1).

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
