From: "Yury V. Umanets" <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [patch] remove null-ifiers
Date: Tue, 27 Jan 2004 19:44:46 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075221885.26178.8.camel@firefly>
References: <E1AgkrW-00080w-00@jaguar.mkp.net>
	 <20040127150954.GA12740@hell.org.pl>
	 <20040127154314.GY11844@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040127154314.GY11844-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Jes Sorensen <jes-dtAfj9ClZIwnoBwkMbRkTB2eb7JE58TQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 2004-01-27 at 18:43, Matthew Wilcox wrote:
> On Tue, Jan 27, 2004 at 04:09:55PM +0100, Karol Kozimor wrote:
> > > -static uid_t asus_uid = 0;
> > > -static gid_t asus_gid = 0;
> > > +static uid_t asus_uid;
> > > +static gid_t asus_gid;
> > 
> > We certainly *don't* want to do that, last time I checked C did not
> > actually guarantee to zero out uninitialized variables -- unless it's
> > different in the kernelspace. Are you sure pointers are initialized as
> > NULLs?
> 
> Looks like you checked the wrong standard then.  Global variables are
> guaranteed to be zeroed, stack variables (ie function-local) have the
> behaviour you described.  Jes' patch is correct.

Global uninitialized variables should be located in BSS section of ELF. 

Then somebody should initialize BSS at the start of a program. In user
space this is done by crt.* small objects written in assembler and
built-in to each application by gcc.

In kernel space this should be done by kernel itself. And I guess, this
is done. So, I don't see any reasons to initialize global variables and
thus to make kernel data segment bigger...


-- 
umka



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
