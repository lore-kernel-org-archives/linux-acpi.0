From: Hamie <hamish@travellingkiwi.com>
Subject: Re: [ACPI] Re: ACPI vs Asus A8v
Date: Sat, 05 Mar 2005 22:51:01 +0000
Message-ID: <422A37D5.8080704@travellingkiwi.com>
References: <42289943.6030303@travellingkiwi.com> <20050305142245.40c8914a.vsu@altlinux.ru>
Reply-To: gentoo-amd64@lists.gentoo.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Post: <mailto:gentoo-amd64@gentoo.org>
List-Help: <mailto:gentoo-amd64-help@gentoo.org>
List-Unsubscribe: <mailto:gentoo-amd64-unsubscribe@gentoo.org>
List-Subscribe: <mailto:gentoo-amd64-subscribe@gentoo.org>
In-Reply-To: <20050305142245.40c8914a.vsu@altlinux.ru>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: gentoo-amd64@lists.gentoo.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Sergey Vlasov wrote:

>On Fri, 04 Mar 2005 17:22:11 +0000 Hamie wrote:
>
>  
>
>>I have an athlon64 in an Asus A8V motherboard, running gentoo with 
>>kernel 2.6.11 (Also tried with 2.6.9 and 2.6.10). Although it works, and 
>>cool&quiet kicks in before boot, I can get no thermal or fan information 
>>from acpi...
>>    
>>
>[skip]
>  
>
>>What sort of info & control SHOULD I be able to see out of this 
>>motherboard? How can I get the level of control that Asus offer with 
>>their windoze applications?
>>    
>>
>
>You should try to use lm_sensors - there are some success reports
>about this board:
>
>http://archives.andrew.net.au/lm-sensors/msg29514.html
>
>In fact, most desktop machines do not support access to thermal or fan
>information via ACPI (because the code for this is not present in
>DSDT); and even if it is supported, the capabilities compared to
>lm_sensors are reduced (e.g., most hardware monitoring chips support
>voltage monitoring, which is not available through ACPI interfaces).
>  
>
Thanks for that. I guess I've been spoilt by using laptops mostly.

lm_sensors finds the readings fine... Now all I have to do is work out 
which is which :)

Hamish.
