From: John O'Hagan <johnohagan-q6EoVN9bke7vnOemgxGiVw@public.gmane.org>
Subject: Re: Re: S3 Suspend input devices problem with 2.6.12
Date: Sat, 1 Oct 2005 00:09:36 +1000
Message-ID: <200510010009.36333.johnohagan@iprimus.com.au>
References: <200509270001.58875.johnohagan@iprimus.com.au> <20050927070427.GA4676@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050927070427.GA4676-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 27 September 2005 17:04, Stefan Seyfried wrote:
> On Tue, Sep 27, 2005 at 12:01:58AM +1000, John O'Hagan wrote:
> > So, my questions are: why does S3 suspend (and not S4) shuffle the
> > devices
[...]
>>? I notice that the keyboard and
> > touchpad are initialized early in the boot process. Can they somehow be
> > reinitialized after suspend? Is udev involved? Or is there a
> > better solution?
>
> I had something similar on a sony vaio, the touchpad would get a mux error
> on resume, disconnect and reconnect itself and then get a different device
> node. It didn't bother me much, since the newer X versions can cope with
> changing device nodes. Anyway, Vojtech diagnosed this and added a DMI match
> for this machine to disable mux mode.
>
> You can try if it also happens with "i8042.nomux" parameter.

Thanks for your reply, Stefan. I tried the option you suggest, but for me it 
disables the touchpad completely. I tried again using the generic mouse 
driver - instead of synaptic - and this time S3 worked! Maybe because of my 
recent kernel upgrade. I then worked out how to switch off the stuck-on fan 
using echo 3 > /proc/acpi/fan/FAN/state. 

All was well...but alas, this story has a tragic end! I soon started getting 
error messages to the effect that my file system had been remounted 
read-only. A reboot failed, and it was only after a long session with a 
rescue disk and  a manual fsck, that I was able to boot again. There had been 
widespread filesystem corruption on / ; no data lost, but a lot of 
reconfiguring was required.

Just to be sure, I backed everything up carefully and tried again. This time, 
not only did resume fail (locked mouse and scrambled screen) , but the 
filesystem corruption occurred again, this time on my /home.

I don't think I will risk trying S3 again on my hardware until I can find some 
advice on how to protect against this kind of problem. Does anyone have any?

Thanks,

John


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
