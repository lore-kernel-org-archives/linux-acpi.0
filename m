From: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>
Subject: Re: OneTouch support on Satellite 3k, and possible thermal control policy for some Omnibook laptop. (was Report:...)
Date: Wed, 24 Jul 2002 01:40:53 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200207232244.g6NMiJK05078@pfn1.pefnos>
References: <1024676521.1631.27.camel@buckelwal> <20020629212435.GA9078@poup.poupinou.org> <20020723074420.GC116@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20020723074420.GC116-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> > For now, with the omke.pl (can be found on http://sf.net/projects/omke)
> > I can switch LCD on/off (even if actually I found another method)
> > and
>
> What method did you find for switching LCD?
> Pavel

The omke.pl fiddles with some XE3 specific register (hw. port), which 
controls all that. I don't write the omke, but I monitor the lists..

IMHO don't patch your kernel. If a perl script can modify the reg and exit, 
it's better that way (than adding one more deamon).

For any help with XE3, ask me in personal, I may know. 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
