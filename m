From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Wed, 31 Jul 2002 20:57:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020731185719.GA20627@dutidad.twi.tudelft.nl>
References: <200207311759.g6VHx0H13028@mailhst2.its.tudelft.nl> <20020731183327.GE20461@dutidad.twi.tudelft.nl> <20020731184246.382.qmail@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020731184246.382.qmail-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 31, 2002 at 12:42:45PM -0600, Kevin Fenzi wrote:
> thanks for the patch!

Thanks for testing!

> I need to do some more testing... not sure I had any 3d stuff running
> at any point, but it seems to work. 

There _might_ be a problem with the DRI install.sh script being so paranoid
about alien libGL libs that it moves yours somewhere else...  I'm going to
fix that soon.

If you can see a message in your XFree86.log like this:
(II) RADEON(0): Direct rendering enabled after VT switch
after switching back from the console, it means everything is hunky dory.
Just remember to test for the radeon usecount before you suspend...

Thanks,
Charl

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
