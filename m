From: Carl Thompson <cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>
Subject: Re: CX > 1 support for Athlon SMP systems
Date: Wed, 24 Jul 2002 11:40:51 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1027536051.3d3ef4b31fef6@carlthompson.net>
References: <3D3B879A.5020401@folkwolf.net> <1027351350.3d3c23363ea3d@carlthompson.net> <3D3CBF78.4010007@folkwolf.net> <1027461971.3d3dd353462e8@carlthompson.net> <3D3E14D9.50009@folkwolf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D3E14D9.50009-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Johnathan Hicks <thetech-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Quoting Johnathan Hicks <thetech-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>: 
 
> Carl Thompson wrote: 
> > Wow.  This actually seems to work on my Sony laptops.  But I 
> > wonder if it is really puting the CPU in C2 because there is no 
> > additional power savings or temperature reduction than using ACPI.  
> > Is there any way to test if CPU is going in C2 state?  
>  
> I can't think of anything at the hardware level, but you do a printk 
> or something inside the while loop that contains the inb() in the 
> idle loop. 
 
What I mean is I know the loop is executing, but how do I know the 
processor is _really_ in C2?  I was expecting a significant change in 
batterly life and CPU temp vs. the C1 state that ACPI put my CPU in.  
I haven't run definitive tests, but at best I'm only at most 15-20 
minutes more battery life (if any at all). 
 
> ... 
 
> --John 
 
Carl Thompson 
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
