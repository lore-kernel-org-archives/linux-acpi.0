From: Carl Thompson <cet-GxmFRYwVNOxKOnpN5g9PlQ@public.gmane.org>
Subject: Re: CX > 1 support for Athlon SMP systems
Date: Tue, 23 Jul 2002 15:06:11 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1027461971.3d3dd353462e8@carlthompson.net>
References: <3D3B879A.5020401@folkwolf.net> <1027351350.3d3c23363ea3d@carlthompson.net> <3D3CBF78.4010007@folkwolf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3D3CBF78.4010007-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>
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

Wow.  This actually seems to work on my Sony laptops.  But I wonder if 
it is really puting the CPU in C2 because there is no additional power 
savings or temperature reduction than using ACPI.  Is there any way to 
test if CPU is going in C2 state? 
 
At any rate, since the power savings is comparable to ACPI and the 
only reason I was using ACPI on these laptops was for the power 
savings, I have switched to using lvcool + APM instead of ACPI.  
Battery life seems about the same, and it eliminates the issues I was 
having with ACPI (CPU usage reading battery status, dropped 
characters, USB weirdness, undocumented inteface, etc). 
 
BTW, APM uses about 1/50th to 1/100th the processor time reading 
battery status on my laptop compared to using ACPI.  No joke. 
 
Carl Thompson 
 
 
Quoting Johnathan Hicks <thetech-Pn2JTpibVOrk1uMJSBkQmQ@public.gmane.org>: 
 
> Carl Thompson wrote: 
> > Any idea how to get C2 on a UP Via Athlon board?  
> >   
> > Thanks,  
> > Carl Thompson  
>  
> Tony mentions VCool and LVCool in his comments so you could try 
> investigate  
> those. Looks like LVCool is the linux version of VCool. If that 
> doesn't work  
> for you, you might be able to grab the data sheets for your chipset 
> and modify  
> some code to make things work. ;-) 
>  
> --John 
>  
>  
>  
>  
> ------------------------------------------------------- 
> This sf.net email is sponsored by:ThinkGeek 
> Welcome to geek heaven. 
> http://thinkgeek.com/sf 
> _______________________________________________ 
> Acpi-devel mailing list 
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org 
> https://lists.sourceforge.net/lists/listinfo/acpi-devel 
>  
>  
 
 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
