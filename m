From: "Charl P. Botha" <c.p.botha-ra0OqMccq8edIhEUFHOBvg@public.gmane.org>
Subject: Re: Re: Compaq Presario 2800T
Date: Tue, 6 Aug 2002 17:36:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020806153647.GP7148@dutidad.twi.tudelft.nl>
References: <200208010551.BAA23125@biohazard-cafe.mit.edu> <20020803220614.21895.qmail@scrye.com> <1028528792.7332.14.camel@anodyne.mandal> <20020805150428.10039.qmail@scrye.com> <1028614416.4553.3.camel@localhost.localdomain> <20020806081618.GA7148@dutidad.twi.tudelft.nl> <20020806153127.23056.qmail@scrye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020806153127.23056.qmail-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Kevin Fenzi <kevin-acpi-+bl/7iUgRMUAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 06, 2002 at 09:31:24AM -0600, Kevin Fenzi wrote:
> Charl> FWIW, my dim/bright keys (Fn-F6 and Fn-F6) always work and the
> Charl> brightness level is even retained across reboots.  The binaries
> Charl> on http://cpbotha.net/dri_reinit.html have been updated,
> Charl> although I doubt that thet changes have to do with your
> Charl> brightness settings.
> 
> Thanks, I will try the updated ones as soon as I get a chance. 
> Whats changed? Same diff against newer dri? 

There is more detail at cpbotha.net/dri_reinit.html.

Basically, Michel Dänzer has re-engineered my concept to make it more
stable.  You can now do things like run multiple DRI-capable servers at the
same time and switch between them... they will automatically switch between
hardware and software 3D depending on who's holding a lock on the Radeon
hardware.  My kludge could also do this, but would break under certain
circumstances.

The suspend/resume software is still more or less the same.

-- 
charl p. botha http://cpbotha.net/ http://visualisation.tudelft.nl/


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
