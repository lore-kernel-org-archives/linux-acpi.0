From: James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org>
Subject: Re: question of appropriateness
Date: Sun, 29 May 2005 13:18:32 -0700
Message-ID: <1117397912.24721.5.camel@localhost.localdomain>
References: <1117244104.21648.1.camel@localhost.localdomain>
	 <20050528101450.GA19354@fingerbrecher>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050528101450.GA19354@fingerbrecher>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

After noticing that the reply to on this list doesn't work the way I expected... sorry..


On Sat, 2005-05-28 at 10:14 +0000, Sebastian Henschel wrote:
> hello James...
> 
> * James Sparenberg <james-q+VOwRQyn90NJZHkBl2fuw@public.gmane.org> [2005-05-28 09:19 +0000]:
> > 
> >    Is this the correct list to receive some guidance on fixing a very
> > badly broken dsdt table for my laptop (37 errors 1 warning when trying
> > to compile it.) or should I use another list? 
> 
> yes, have a try.
> 
> cheers,
>  Sebastian

Ok Laptop in question is an Acer Aspire 3000 which other than acpi
hardware is 100% (nice feeling)  Rather than put up all of the errors
I'll break them into 3 groups.

1.  1094 error (which I've a feeling if I fix others will follow) of
which there are 3 types. 

      dsdt.dsl   743:                     0x0100, 0x00,,)
      Error    1094 -                                   ^ Missing
ResourceSource string (required)

      dsdt.dsl   750:                     , AddressRangeMemory,
TypeStatic)
      Error    1094 -            Missing ResourceSource string
(required) ^

The second one I have about 20 of .... each time the Add........ line
appears so one fix style should get me.

2.  The other errors I'm not finding docs on are related to PPC 

      dsdt.dsl  2506:                             If (LNot (LEqual
(\_PR.CPU0._PPC, 0x00)))
      Error    1022 -                                      Object does
not exist ^               (\_PR.CPU0._PPC)

      dsdt.dsl  2508:                                 Store (0x00,
\_PR.CPU0._PPC)
      Error    1022 -                                     Object does
not exist ^  (\_PR.CPU0._PPC)

      dsdt.dsl  2516:                             If (LLess
(\_PR.CPU0._PPC, Local1))
      Error    1022 -                               Object does not
exist ^  (\_PR.CPU0._PPC)

There are about 10 of these.    I'd appreciate any tips/pointers/FM's
etc any one here can give.  I can't find any evidence of an ECTC on this
one but then again I've just made the decision to dive into this so I'm
in the process of learning where everything is.  Interesting side note.
WinXP on this box (keeping it for the warranty grrrr) also has troubles
with aspects of this DSDT as well.  

James






-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
