From: Mattia Dongili <dongili-vcC760zL2fQ1GQ1Ptb7lUw@public.gmane.org>
Subject: Re: Strange ACPI way of work in Sony VAIO GRX600
Date: Tue, 4 Feb 2003 09:52:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030204095216.7ce83ada.dongili@supereva.it>
References: <1044313902.21776.13.camel@galileo.homenet.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1044313902.21776.13.camel-YsvTK5mC77CNMNO9ztqOseFciLI1ps7f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: alx <alexs81-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> but sometimes acpi patch  20021205 (on 2.4.20)hat a little utility 
> tells me that themperature goes to 0 and battery has strange state info

this happened to me too using spictrl or setbrightness while on battery.
it doesn't seem to happen anymore (I'm using acpi-20021212). I think they just write some more memory than they should but I've never debbuged it.

> I was interested in patching ACPI for sony vaio series, but I just need
> some suggestion on what can be done.
> Another thing is that a little utility which doesn't require acpi to
> work (vaiobat) hangs when acpi doesn't works, but work great when acpi
> works.
> 
> When it happen I've to change some state in acpi subsystem: i mean one
> of these action bring acpi to work properly again
> 1) close lid switch
> 2) press power button
> 3) plug ac-ADAPTER
> 4) remove and insert again battery

never tried this *solution* :)

--
mattia

> 
> I think there is a overflow somewehere
> 
> TIA for suggestion
> Bye
> Alx
> 
> -- 
> int a=10000,b,c=2800,d,e,f[2801],g;main(){for(;b-c;) f[b++]=a/5;
> for(;d=0,g=c*2;c-=14,printf("%.4d"e+d/a),e=d%a)for(b=c;d+=f[b]*a,
> f[b]=d%--g,d/=g--,--b;d*=b);}
> 
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
