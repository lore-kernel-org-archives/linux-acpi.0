From: Jochen Reinwand <jbr.1-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: Testing: NVidia closed driver fails.
Date: Fri, 20 Sep 2002 12:06:16 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209201206.16776.jbr.1@gmx.net>
References: <Pine.LNX.4.44.0209191645050.961-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0209191645050.961-100000-yZQdDDOm3n9ZQn2sFP3R7eTW4wlIGRCZ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>, "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

It really looks like it is NVidia's fault. But I don't think that it is not of 
any interest for Linux, that there are problems with NVidia boards!
The GeForce cards are at the moment the most used graphic boards. Everyone who 
wants to have fast 3D support for Linux seems to prefer NVidia boards. A few 
minutes ago a played a deathmatch with Unreal Tournament 2003 Demo and was 
very happy that everything worked fine within Linux. I really don't want to 
miss it ;-)
Perhaps NVidia just has to disable something within acpi like they do with 
apm... or make there driver open source.......

Jochen

Patrick Mochel wrote:
> > To A. Grover: if the trouble lies in the bttv driver, the kernel will be
> > considered broken until both drivers co-exist..
>
> Actually, if it's a problem with an nVidia video card, or something that
> is using the proprietary nVidia driver, the driver is considered broken
> and it is nVidia's problem.
>
> Because their driver is closed-source, kernel developers should not spend
> the time to reverse engineer the driver or attempt to figure out what
> they're trying to do. There are better things to worry about.
>
> Now, if you see this happening with an open-source driver, then we can
> help..
>
> 	-pat



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
