From: Jing Su <gargamel.su-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: S3 resume in 2.6.10 on Dell D600 with black screen
Date: Tue, 11 Jan 2005 16:07:33 -0500
Message-ID: <f11de95f050111130766da1f1d@mail.gmail.com>
References: <Pine.LNX.4.58.0501112144550.13409@homel.vsb.cz>
Reply-To: Jing Su <gargamel.su-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0501112144550.13409-O3VfBSJ9GAHt0A3bznZ7pA@public.gmane.org>
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

>   But with kernel 2.6.10 after resume from S3 I have black screen. The
> same result with radeonfb or with vga only (tested without X).

I have been experiencing the same problems with kernel 2.6.9 as well. 
The system works perfectly after suspend to disk (S4).  But with S3, I
get the blank screen with and without X.  I'm running Fedora 3, in an
Acer with an integrated Intel display adapter.

After resume from S3, the rest of the system comes up fine; I can even
SSH into the machine.  However, the display adapter does not come back
up.  The screen stays blank, with the backlight off.  I've tried
toggling the LCD/VGA display switch hotkey, to no avail.  Also, I've
brought the machine out of S3 in console, and then attempted to start
X.  X fails to start.  /var/log/messages shows the system going into
S3, and then coming out.  There are no error messages reported about
failure to re-start the video adapter.

I'm a competent programmer, though I have no experience with Kernel or
ACPI development.  If someone can give me some hints/pointers, I think
I can try to help out with this issue.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
