From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: S3 Suspend input devices problem with 2.6.12
Date: Tue, 27 Sep 2005 09:04:27 +0200
Message-ID: <20050927070427.GA4676@message-id.gmane0305.slipkontur.de>
References: <200509270001.58875.johnohagan@iprimus.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200509270001.58875.johnohagan-q6EoVN9bke7vnOemgxGiVw@public.gmane.org>
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

On Tue, Sep 27, 2005 at 12:01:58AM +1000, John O'Hagan wrote:
 
> So, my questions are: why does S3 suspend (and not S4) shuffle the devices 

It is probably luck that it does not happen with S4.

> around, and how can it be prevented? I notice that the keyboard and touchpad 
> are initialized early in the boot process. Can they somehow be reinitialized 
> after suspend? Is udev involved? Or is there a 
> better solution?

I had something similar on a sony vaio, the touchpad would get a mux error on
resume, disconnect and reconnect itself and then get a different device node.
It didn't bother me much, since the newer X versions can cope with changing
device nodes. Anyway, Vojtech diagnosed this and added a DMI match for this
machine to disable mux mode.

You can try if it also happens with "i8042.nomux" parameter.
-- 
Stefan Seyfried



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
