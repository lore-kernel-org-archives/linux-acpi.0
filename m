From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: AE_BAD_HEX_CONSTANT
Date: Tue, 16 Nov 2004 15:19:33 -0800
Message-ID: <419A8B05.5050401@root.org>
References: <37F890616C995246BE76B3E6B2DBE05502A86F8F@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05502A86F8F-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, Paulo da Silva <pvmagacho78-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I agree with this behavior.  Thanks for adjusting to it.

-Nate

Moore, Robert wrote:
> It's not really clear from the ACPI spec, but it would appear that a
> store to an index on a package should just overwrite any existing
> object.
> 
> If nothing else, the defacto standard interpreter seems to do this.....
> 
> I've changed this behavior for the next release, probably this week.
> 
> Bob
> 
> 
> 
>>-----Original Message-----
>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Moore, Robert
>>Sent: Friday, November 12, 2004 3:09 PM
>>To: Nate Lawson; Bruno Ducrot
>>Cc: Paulo da Silva; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>Subject: RE: [ACPI] AE_BAD_HEX_CONSTANT
>>
>>I'm looking at this.
>>Bob
>>
>>
>>
>>>-----Original Message-----
>>>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>>>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Nate Lawson
>>>Sent: Friday, November 12, 2004 2:57 PM
>>>To: Bruno Ducrot
>>>Cc: Paulo da Silva; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>>>Subject: Re: [ACPI] AE_BAD_HEX_CONSTANT
>>>
>>>Bruno Ducrot wrote:
>>>
>>>>On Tue, Nov 09, 2004 at 11:49:44AM -0800, Nate Lawson wrote:
>>>>
>>>>
>>>>>                       Name (BT0I, Package (0x0D)
>>>>>                       {
>>>>>                           0x01,
>>>>>                           0x19C8,
>>>>>                           0x19C8,
>>>>>                           0x01,
>>>>>                           0x39D0,
>>>>>                           0x014A,
>>>>>                           0xDC,
>>>>>                           0x012C,
>>>>>                           0x0294,
>>>>>                           "ANA",
>>>>>                           "110",
>>>>>                           "Lion",
>>>>>                           0x00
>>>>>                       })
>>>>>
>>>>>Looking more carefully, it looks like commenting out just the last
>>
>>line
>>
>>>>>("Acer") would suffice.  Index 0xC is actually an integer (0x00)
> 
> so
> 
>>this
>>
>>>>>is what triggers the Integer conversion.  I'm not sure how the
>>>>>conversion rules should be modified to take this into account.
>>>>>
>>>>
>>>>
>>>>I suggest to replace the last integer with a string like "Acer".
>>
>>Since
>>
>>>>anyway BT0I is expected to be a package returned by a _BIF method,
>>
>>it
>>
>>>>must be compatible with ACPI spec (look at 11.2.2.1).
>>>>
>>>
>>>I agree to test this, but I'd also like to see acpi-ca improved to
>>>handle this case with the stock ASL.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
