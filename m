From: Tod Morrison <tmorriso-o2OswTf4RFv//ikEAC0814dd74u8MsAO@public.gmane.org>
Subject: Re: RE: preparing toshiba_acpi driver release
Date: Mon, 26 Jan 2004 23:33:43 -0700 (MST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0401262326530.5251@localhost.localdomain>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A54@hdsmsx402.hd.intel.com>
 <20040127031247.GA28233@hell.org.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040127031247.GA28233-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have a Dell Inspiron 8500, I'd be happy to play tester with when you're 
looking for a generalized solution. I did have one thought (quite beyond 
me to implement though), I was looking at the ACPI VID extensions and 
wondered if LCD._DSS could be used to our advantage. It appears that it's 
designed to allow the OS to handle video output switching, i.e. 

  turn off LCD -> turn on CRT

What I thought was that I don't see a reason we couldn't just turn off 
LCD output, i.e. call 

  LCD._DSS(0);

to turn off output, and 

  LCD._DSS(80000001L);

to turn it back on. Anyway, I'm really unqualified to say whether this 
make any sense, it was just a thought.

Tod Morrison <tmorriso-o2OswTf4RFv//ikEAC0814dd74u8MsAO@public.gmane.org>
   http://math.cudenver.edu/~tmorriso

  "Everyone thinks of changing the world,
  but no one thinks of changing himself."
  - Leo Tolstoy

On Tue, 27 Jan 2004, Karol Kozimor wrote:

> Thus wrote Brown, Len:
> > I was thinking about ergonomics rather than power-savings -- though
> > probably brightness control has some power savings benefits too -- maybe
> > somebody on the list has numbers for screen power consumption?
> 
> Last time I checked it was about 6 W for my 15" display (100% brightness,
> power consumption goes down linearly).
> 
> What I consider more important, is the ability to switch the LCD on / off
> by demand -- unfortunately, DPMS is mostly unsupported on modern machines
> and a generic approach (provided it works) could make a difference here.
> 
> Once I update the acpi4asus driver, I'll take a look on how those generic
> methods to manipulate video work here and see where it gets me.
> 
> Best regards,
> 
> -- 
> Karol 'sziwan' Kozimor
> sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
